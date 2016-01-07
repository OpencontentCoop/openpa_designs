{* eccezione per il presidente *}
{def $current_object_id = $node.contentobject_id}
{if $node.contentobject_id|eq(2985)}
  {set $current_object_id = 2606}
{/if}

{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>        
    </div>
        
    <div class="nav-section">
      {if is_set( $openpa.content_main.parts.image )}
        {include uri='design:atoms/image.tpl' item=$node image_class=large image_css_class="media-object tr_all_long_hover"}
    {/if}  
    </div>
    
    <div class="content-main full-stack">        
      <ul class="fa-ul">
		{if $node|has_attribute('rappresentante')}
		  {foreach $node.data_map.ruolo_attuale.content.relation_list as $relation}
			<li><i class="fa-li fa fa-user"></i> {fetch(content,object,hash(object_id,$relation.contentobject_id)).name|wash()}</li>
		  {/foreach}
		{/if}
		{if $node|has_attribute('rappresentante')}
		  <li><i class="fa-li fa fa-institution"></i> {attribute_view_gui attribute=$node.data_map.rappresentante href="no-link"}</li>
		{/if}
        <li><i class="fa-li fa fa-institution"></i> {attribute_view_gui attribute=$node.data_map.ruolo2 href="no-link"}</li>

    {def $search_materie = fetch( ezfind, search, hash( sort_by, hash( 'name', 'asc' ), limit, 200, class_id, array( 'materia' ), filter, array( concat( 'submeta_referente_politico___id_si:', $current_object_id ) ) ) )}
    {if $search_materie.SearchCount}      
		  <li><i class="fa-li fa fa-tag"></i> <strong>Referente politico per le materie:</strong>
			<ul class="list-unstyled">
			{foreach $search_materie.SearchResult as $item}
			  <li>{$item.name|wash()}</li>
			{/foreach}
			</ul>
		  </li>
    {/if}
    
    {def $search_desginazioni = fetch( ezfind, search, hash( class_id, array( 'designazione' ), filter, array( concat( 'submeta_persona_designata___id_si:', $current_object_id ) ) ) )}
    {if $search_desginazioni.SearchCount}      
		  <li><i class="fa-li fa fa-star"></i> <strong>Persona designata per:</strong>
			<ul class="list-unstyled">
			{foreach $search_desginazioni.SearchResult as $item}
			  <li><a href="{$item.url_alias|ezurl(no)}">{$item.name|wash()}</a></li>
			{/foreach}
			</ul>
		  </li>
    {/if}
        
      </ul>
    </div>
      
    <div class="content-related">
      
      <h2>Attività</h2>
      <div class="widget">
        
      {ezscript_require( array( 'ezjsc::jquery', 'highcharts_presenze_utente.js', 'highcharts.js' ) )}
      <div class="presenze_utente_pie_container"
           data-title="Presenze 2015"           
           data-url="{concat('openpa/data/percentuale_presenze_seduta/?uid=', $current_object_id)|ezurl(no)}"
           style="min-width: 220px; height: 200px; max-width: 600px; margin: 0 auto">            
      </div>  
        
      <div class="widget_content">
      
      <ul class="list-unstyled">
        {def $search_osservazioni_c = fetch( ezfind, search, hash( class_id, array( 'seduta' ), limitation, array(), filter, array( concat( 'submeta_presenti___id_si:', $current_object_id ), 'subattr_organo___name____s:Consiglio' ) ) )}
        <li>{$search_osservazioni_c.SearchCount} sedute di Consiglio</li>
        {def $search_osservazioni_g = fetch( ezfind, search, hash( class_id, array( 'seduta' ), limitation, array(), filter, array( concat( 'submeta_presenti___id_si:', $current_object_id ), 'subattr_organo___name____s:Giunta' ) ) )}
        <li>{$search_osservazioni_g.SearchCount} sedute di Giunta</li>
        {def $count_osservazioni = fetch( content, tree_count, hash( parent_node_id, 1, limitation, array(), class_filter_type, 'include', class_filter_array, array( 'osservazione' ), attribute_filter, array( array( 'owner','=', $current_object_id ) ) ) )}
        <li>{$count_osservazioni} osservazioni scritte</li>
        {def $search_audizioni = fetch( ezfind, search, hash( class_id, array( 'audizione' ), limitation, array(), filter, array( concat( 'submeta_referente_politico___id_si:', $current_object_id ) ) ) )}
        <li>{$search_audizioni.SearchCount} audizioni</li>
      </ul>
      
      </div>
      </div>
      
    </div>                    
</div>

{if $openpa.content_date.show_date}
  <div class="row"><div class="col-md-12">
    <p class="pull-right">{include uri=$openpa.content_date.template}</p>
  </div></div>
{/if}
