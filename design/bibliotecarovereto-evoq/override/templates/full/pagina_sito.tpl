{def $calendar = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'CalendarNode', 'content.ini' ) ) )}

{if $node.path_array|contains($calendar.node_id)}
    {include uri=concat('design:parts/pagina_sito/nav-left.tpl')}
{else}
    {include uri=concat('design:parts/pagina_sito/default.tpl')}
{/if}

{undef $calendar}
