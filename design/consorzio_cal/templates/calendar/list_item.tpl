{def $stuff = object_handler($item.node).gestione_sedute_consiglio.stuff}
{def $prefix = false()}
{if $item.node.class_identifier|eq('scheda_informativa')}
  {set $prefix = "Sportello "}
{/if}
<li><a class="has-tooltip" href={$event.main_url_alias|ezurl()} title="{$item.from|datetime( 'custom', '%H:%i')} - {$item.to|datetime( 'custom', '%H:%i')} {$prefix}{$item.name|wash()} [{$stuff.current_state.current_translation.name|wash()}]" data-toggle="tooltip" data-placement="top">{$prefix}{$item.name|wash()}</a></li>
{undef $stuff}