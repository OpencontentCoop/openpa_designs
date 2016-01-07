{if count( $openpa.content_ruoli_comune.ruoli.struttura )}
<div class="widget">
	<div class="widget_title">        	
      <h3>Riferimenti</h3>    
	</div>
	<div class="widget_content">	  
    {node_view_gui content_node=$node view=staff_area}
	</div>
</div>
{/if}

{if count( $openpa.contacts.data )|gt(0)}
<div class="widget">
	<div class="widget_title">
	  <h3>Contatti</h3>
	</div>
	<div class="widget_content">
	  {include uri="design:parts/contacts.tpl" data=$openpa.contacts.data}
	</div>
</div>
{/if}

{*def $news = fetch( ezfind, search, hash( subtree_array, array( $node.node_id ), class_id, array( 'avviso' ), limit, 3, sort_by, hash( published, desc ) ) )}
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
{undef $news*}