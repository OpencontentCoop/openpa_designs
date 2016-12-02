{set_defaults(hash(
  'page_limit', 10
))}

{def $non_admin_filter = hash('filter', array('attr_visibile_b:true'))}
{if $node.can_edit}
  {set $non_admin_filter = hash()}
{/if}
{def $data = class_search_result(  hash( 'subtree_array', array($node.node_id),                                          
                                          'sort_by', hash( 'name', 'asc' ),
                                          'limit', $page_limit )|merge($non_admin_filter),
								   $view_parameters )}
<div class="row">
  <div class="col-md-8">
	{if and( $data.is_search_request, is_set( $view_parameters.class_id ) )}
	 {include name=class_search_form_result
			  uri='design:parts/class_search_form_result.tpl'
			  data=$data
			  page_url=$node.url_alias
			  view_parameters=$view_parameters
			  page_limit=$page_limit}  
	{else}
	
	 
    {def $default_search = fetch( ezfind, search, hash( 'subtree_array', array($node.node_id),                                          
                                          'class_id', 'documentazione',
                                          'sort_by', hash( 'published', 'desc' ),
                                          'offset', $view_parameters.offset,
                                          'limit', $page_limit )|merge($non_admin_filter) )
         $children_count = $default_search.SearchCount
         $children = $default_search.SearchResult}
    
    
    {if $children_count}
      <div class="content-view-children">  
      {foreach $children as $child }
        {node_view_gui view=line content_node=$child image_class=small}
        {delimiter}{$delimiter}{/delimiter}
      {/foreach}
      </div>
    
      {include name=navigator
           uri='design:navigator/google.tpl'
           page_uri=$node.url_alias
           item_count=$children_count
           view_parameters=$view_parameters
           item_limit=$page_limit}
    
    {/if}
	
	{/if}
  </div>

  {def $currentClass = false()}      
  {def $classes = fetch( 'class', 'list', hash( 'class_filter', array('documentazione') ) )}
  
  {if $data.is_search_request}	
    {set $currentClass = cond( is_set( $data.fetch_parameters.class_id ), $data.fetch_parameters.class_id, $classes[0].id )}  
  {elseif count( $classes )|eq(1)}
    {set $currentClass = $classes[0].id}  	
  {/if}

  {if $currentClass|not()}
    {set $currentClass = $classes[0].id}
  {/if}
  
  {if count( $classes )|gt(0)}
  <div class="col-md-4">
    <div class="widget">
      <div class="widget_title">
        <h3>Cerca</h3>
      </div>
      <div class="widget_content">

        {if count( $classes )|gt(1)}
        <ul class="nav nav-tabs" role="tablist">	  
          {foreach $classes as $class}
          <li{if $currentClass|eq( $class.id )} class="active"{/if}><a href="#{$class.identifier}" role="tab" data-toggle="tab">{$class.name|wash()}</a></li>
          {/foreach}	  
        </ul>      
        {/if}
        
        <div class="tab-content">
          {foreach $classes as $class}
          <div class="tab-pane{if $currentClass|eq( $class.id )} active{/if}" id="{$class.identifier}">
          {class_search_form( $class.identifier, hash( 'RedirectNodeID', $node.node_id ) )}
          </div>
          {/foreach}
        </div>
      
      </div>
    </div>	
  </div>
  {/if}
</div>