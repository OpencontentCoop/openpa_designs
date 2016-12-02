{def $prefix = false()}
{if is_set( $item.from )}
  {def $from = $item.from|datetime( 'custom', '%M' )
	   $to = $item.from|datetime( 'custom', '%j' )
	   $node = $item.node}
  {if $item.node.class_identifier|eq('scheda_informativa')}
	{set $prefix = "Sportello "}
  {/if}
{else}
  {def $from = $item.data_map.from_time.content.timestamp|datetime( 'custom', '%M' )
	   $to = $item.data_map.from_time.content.timestamp|datetime( 'custom', '%j' )
	   $node = $item}
  {if $item.class_identifier|eq('scheda_informativa')}
	{set $prefix = "Sportello "}
  {/if}	   
{/if}
{def $stuff = object_handler($node).gestione_sedute_consiglio.stuff}
<div class="row event-item">
    <div class="col-xs-4 calendar-date">
        <span class="month">{$from}</span>
        <span class="day">{$to}</span>
    </div>
    <div class="col-xs-8">
        {node_view_gui content_node=$node view=text_linked shorten=120}

        <small><span class="label label-default">{$stuff.current_state.current_translation.name|wash()}</span></small>
        {if and( $node|has_attribute( 'convocazione' ), $stuff.current_state.identifier|eq('sent'))}
          {if $node|has_attribute( 'convocazione' )}
            {def $attribute = $node|attribute( 'convocazione' )}          
            <p><small><i class="fa fa-download"></i> <a href="{concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl(no)}">Scarica ordine del giorno</a></small></p>      
            {undef $attribute}
          {/if}
        {/if}
    </div>
</div>
{undef $stuff}