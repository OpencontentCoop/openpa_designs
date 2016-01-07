{def $area = $node|find_first_parent( 'area' )
     $area_openpa = object_handler($area)}

<div class="widget">
  <div class="widget_title">
	<h3>Riferimenti</h3>
  </div>
  <div class="widget_content">
	
	{if $area}	  
		{if count( $area_openpa.content_ruoli_comune.ruoli.struttura )}
		  {foreach $area_openpa.content_ruoli_comune.ruoli.struttura as $ruolo}
			{if $ruolo.name|eq("Responsabile")}
        <h3>Responsabile</h3>        
			  {foreach $ruolo.data_map.utente.content.relation_list as $user}
          {content_view_gui view=dipendente_struttura content_object=fetch( content, object, hash( object_id, $user.contentobject_id ) ) struttura=fetch( content, object, hash( object_id, $ruolo.data_map.struttura_di_riferimento.content.relation_list[0].contentobject_id ) )}
        {/foreach}
			{/if}
		  {/foreach}
		{/if}	  
	{/if}
	{if count( $openpa.content_ruoli_comune.ruoli.struttura )}
	  {foreach $openpa.content_ruoli_comune.ruoli.struttura as $ruolo}
		  <h3>{$ruolo.name|wash()}</h3>
      {foreach $ruolo.data_map.utente.content.relation_list as $user}
        {content_view_gui view=dipendente_struttura content_object=fetch( content, object, hash( object_id, $user.contentobject_id ) ) struttura=fetch( content, object, hash( object_id, $ruolo.data_map.struttura_di_riferimento.content.relation_list[0].contentobject_id ) )}
      {/foreach}
	  {/foreach}
	{/if}
	</ul>
	
	{def $consulenti = fetch( ezfind, search, hash( class_id, array( 'consulente' ), filter, array( concat( 'submeta_progetto___id_si:',  $node.contentobject_id ) ), sort_by, hash( name, asc ) ) )}
	{if $consulenti['SearchCount']|gt(0)}
	  <h3>Consulenti</h3>
	  <ul class="list-unstyled">
	  {foreach $consulenti['SearchResult']  as $item}
		<li>{node_view_gui content_node=$item view=text_linked}</li>
	  {/foreach}
	  </ul>
	{/if}
	{undef $consulenti}
	
  </div>
</div>

{if and( $area, count( $area_openpa.contacts.data )|gt(0) )}
<div class="widget">
	<div class="widget_title">
	  <h3>Contatti</h3>
	</div>
	<div class="widget_content">
	  {include uri="design:parts/contacts.tpl" data=$area_openpa.contacts.data}
	</div>
</div>
{/if}

{def $news = fetch( ezfind, search, hash( subtree_array, array( $node.node_id ), class_id, array( 'avviso' ), limit, 3, sort_by, hash( published, desc ) ) )}
{if $news['SearchCount']|gt(0)}
<div class="widget">
  <div class="widget_title">
	<h3>Ultime notizie</h3>
  </div>
  <div class="widget_content">
    <ul class="list-unstyled">
    {foreach $news['SearchResult']  as $item}
    <li class="media">
      {if $item|has_attribute( 'image' )}
        <a class="pull-left" href="{$item.url_alias|ezurl(no)}">
          {attribute_view_gui attribute=$item|attribute('image') image_class=squaremini css_class=false() image_css_class="m_left_20 d_inline_middle"}
        </a>        
      {/if}
      <div class="media-body">
        <small>{$item.object.published||l10n(date)}</small>
        {node_view_gui content_node=$item view=text_linked}
      </div>
    </li>
    {/foreach}
    </ul>
  </div>
</div>
{/if}