<div class="content-view-line class-{$node.class_identifier} row">
	<div class="media-body">
        <h3 class="media-heading">
            <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
        </h3>
        {$node|abstract()}
    </div>
        
    <div class="nav-section">
      {if is_set( $openpa.content_main.parts.image )}
        {include uri='design:atoms/image.tpl' item=$node image_class=large image_css_class="media-object tr_all_long_hover"}
    {/if}  
    </div>
    
    <div class="content-main">        
      <ul class="fa-ul">
{if $node|has_attribute('rappresentante')}
{foreach $node.data_map.ruolo_attuale.content.relation_list as $relation}
        <li><i class="fa-li fa fa-user"></i> {fetch(content,object,hash(object_id,$relation.contentobject_id)).name|wash()}</li>
{/foreach}
{/if}
{if $node|has_attribute( 'rappresentante' )}
        <li><i class="fa-li fa fa-institution"></i> {attribute_view_gui attribute=$node.data_map.rappresentante href="no-link"}</li>
{/if}
        <li><i class="fa-li fa fa-institution"></i> {attribute_view_gui attribute=$node.data_map.ruolo2 href="no-link"}</li>
{*
{def $current_object_id = $node.contentobject_id}
{if $node.contentobject_id|eq(2985)}
{set $current_object_id = 2606}
{/if}      
        {def $search_materie = fetch( ezfind, search, hash( class_id, array( 'materia' ), filter, array( concat( 'submeta_referente_politico___id_si:', $current_object_id ) ) ) )}
        {if $search_materie.SearchCount}      
        <li><i class="fa-li fa fa-tag"></i> <strong>Referente politico per le materie:</strong>
        <ul class="list-unstyled">
        {foreach $search_materie.SearchResult as $item max 2}
          <li>{$item.name|wash()}</li>
        {/foreach}
		{if $search_materie.SearchCount|gt(2)}
			<li><a href="{$openpa.content_link.full_link}">continua...</a></li>
		{/if}
        </ul>
        </li>
        {/if}
  *}      
      </ul>
    </div>
      
</div>
