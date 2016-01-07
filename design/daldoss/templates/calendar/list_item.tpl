{def $prefix = false()}
{if $item.node.class_identifier|eq('scheda_informativa')}
  {set $prefix = "Sportello "}
{/if}
<li><a class="has-tooltip" href={$event.main_url_alias|ezurl()} title="{$item.from|datetime( 'custom', '%H:%i')} - {$item.to|datetime( 'custom', '%H:%i')} {$prefix}{$item.name|wash()}" data-toggle="tooltip" data-placement="top">{$prefix}{$item.name|wash()}</a></li>
  