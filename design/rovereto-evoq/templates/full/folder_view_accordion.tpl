{* Folder - Full view *}
{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $current_user = fetch( 'user', 'current_user' )
     $classes_parent_to_edit=array('file_pdf', 'news')
     $sezioni_per_tutti= openpaini( 'GestioneSezioni', 'sezioni_per_tutti' )
	 $style='col-odd'
}

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

        <h1>{attribute_view_gui attribute=$node.data_map.name}</h1>
	
        {* DATA e ULTIMAMODIFICA *}
        {include name = last_modified
                 node = $node             
                 uri = 'design:parts/openpa/last_modified.tpl'}
    
        {* EDITOR TOOLS *}
        {include name = editor_tools
                 node = $node             
                 uri = 'design:parts/openpa/editor_tools.tpl'}
    
        {* ATTRIBUTI : mostra i contenuti del nodo *}
        {include name = attributi_principali
                 uri = 'design:parts/openpa/attributi_principali.tpl'
                 node = $node}

        {if and( is_set($node.data_map.description), $node.data_map.description.has_content )}
            {attribute_view_gui attribute=$node.data_map.description}
        {/if}
        
        {if and( is_set( $node.data_map.gps ), $node.data_map.gps.has_content )}
            {include name = attributi_principali uri = 'design:parts/openpa/attributi_base.tpl' contentobject_attributes = array( $node.data_map.gps )}		
        {/if}

        {def $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 25 )
             $children=array()
             $children_count=0
             $classes=array()
             $include_exclude=''}
        
{ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js' ) )}

<script type="text/javascript">
{literal}
$(function() {
	$("#{/literal}{$node.name|slugize()}{literal}").accordion({ 
		autoHeight: false,		
		change: function(event, ui) { 
			$('a', ui.newHeader ).addClass('active'); 
			$('a', ui.oldHeader ).removeClass('active');  
		}
	}); 
});
{/literal}
</script>        

        <div class="full-block lista_accordion color color-primary">
            <div id="{$node.name|slugize()}" class="ui-accordion">
        
            {def $node_children = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                                 'sort_by', array( 'name', true() ),
                                                                 'class_filter_type', 'exclude',
                                                                 'class_filter_array', openpaini( 'ExcludedClassesAsChild', 'FromFolder' ) ) )}
            {foreach $node_children as $index => $first_level_child}            
                <div id="{$first_level_child.name|slugize()}" class="border-box box-gray box-accordion ui-accordion-header {if $index|eq(0)}no-js-ui-state-active{/if}">
                    <h4>
                        {if $first_level_child.class_identifier|eq('link')}
                            <a href={$first_level_child.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">{$first_level_child.name|wash()}</a>
                        {elseif is_set($first_level_child.data_map.testo_news)}
                            <a{if $index|eq(0)} class="active"{/if} href={$first_level_child.parent.url_alias|ezurl()}>{$first_level_child.parent.name|wash()}</a>
                        {else}
                            <a{if $index|eq(0)} class="active"{/if} href={$first_level_child.url_alias|ezurl()}>{$first_level_child.name|wash()}</a>
                        {/if}
                    </h4>
                </div>
        
                {* FIGLI *}
                {set $children=array()
                     $children_count=0
                     $classes=array()
                     $include_exclude=''}
            
                {if and( is_set( $node.data_map.classi_filtro ), $node.data_map.classi_filtro.has_content )}
                    
                    {set $classes = $node.data_map.classi_filtro.content|explode(',')}
                    {def $virtual_classes = array()}
                    {foreach $classes as $class}
                        {set $virtual_classes = $virtual_classes|append( $class|trim() )}
                    {/foreach}
                    
                    {if $node.data_map.subfolders.has_content}
                        {def $virtual_subtree = array()}
                        {foreach $node.data_map.subfolders.content.relation_list as $relation}
                            {set $virtual_subtree = $virtual_subtree|append( $relation.node_id )}
                        {/foreach}
                    {else}
                        {def $virtual_subtree = array( $first_level_child.node_id )}
                    {/if}
                    
                    {def $sortArray = $node.object.main_node.sort_array
                         $order = $sortArray[0][0]}
                    {if array( 'published', 'name' )|contains( $order )|not()}
                       {set $order = 'published'}
                    {/if}
                    {if $sortArray[0][1]|eq( 1 )}
                        {def $sortHash = hash( $order, 'asc' )}
                    {else}
                        {def $sortHash = hash( $order, 'desc' )}
                    {/if}
                    
                    {def $search_hash = hash( 'subtree_array', $virtual_subtree,
                                              'offset', $view_parameters.offset,
                                              'limit', $page_limit,
                                              'class_id', $virtual_classes,
                                              'sort_by', $sortHash
                                              )
                         $search = fetch( ezfind, search, $search_hash )}
                         
                    {set $children = $search['SearchResult']
                         $children_count = $search['SearchCount']
                         $show_items=true()}
                    
                {else}
                
                    {* in generale *}
                    {set $classes =  openpaini( 'ExcludedClassesAsChild', 'FromFolder' )
                         $children = fetch( 'content', 'list', hash( 'parent_node_id', $first_level_child.node_id,
                                                                      'offset', $view_parameters.offset,
                                                                      'sort_by', $first_level_child.sort_array,
                                                                      'class_filter_type', 'exclude',
                                                                      'class_filter_array', $classes,
                                                                      'limit', $page_limit ) )
                         $children_count=fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                                'class_filter_type', 'exclude',
                                                                                'class_filter_array', $classes ) )}
                {/if}
            
                
                <div id="{$first_level_child.name|slugize()}-detail" class="ui-accordion-content {if $index|eq(0)}ui-accordion-content-active{/if} {if $index|gt(0)}no-js-hide{/if}">
                {if $children_count|gt(0)}
                    {foreach $children as $child }                    
                        <div class="list">
                            <p><strong>
                            {if $child.class_identifier|eq('link')}
                                <a href={$child.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">{$child.name|wash()}</a>
                            {else}
                                <a{if $index|eq(0)} class="active"{/if} href={$child.url_alias|ezurl()}>{$child.name|wash()}</a>
                            {/if}
                            </strong></p>
                            
                            {include uri='design:block_item/list-item.tpl' name=folder-accordion node=$child show_title=false()}
                        </div>
                        {*include name=navigator
                             uri='design:navigator/google.tpl'
                             page_uri=$node.url_alias
                             item_count=$children_count
                             view_parameters=$view_parameters
                             item_limit=$page_limit*}
                    {/foreach}
                </div>
                {/if}
            {/foreach}
            </div>
        </div>
    
        {* TIP A FRIEND *}
        {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}
    
    </div>
</div>