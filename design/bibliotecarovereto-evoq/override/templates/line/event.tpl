{def $parent_event_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'EventTypesNodeID', 'content.ini' ) ) )
     $types = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id, 'all_relations', false(), 'attribute_identifier', 'event/tipo_evento' ) )
     $biblio_types = array()}

{foreach $types as $t}
    {if eq($t.main_parent_node_id, $parent_event_types.node_id)}
        {set $biblio_types=$biblio_types|append($t)}
    {/if}
{/foreach}

<article>
    {if $node|has_attribute( 'image' )}
        <a href="{$node.url_alias|ezurl('no')}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='event_line' css_class=false() image_css_class="img-responsive"}
        </a>
    {/if}
    <header>
        <a href="{$node.url_alias|ezurl('no')}"><h3>{$node.name|wash()}</h3></a>
        {*<p>{attribute_view_gui attribute=$node|attribute( 'periodo_svolgimento' )}</p>*}
        {if $node.data_map.to_time.has_content}
            {*if eq($node.data_map.from_time.content.timestamp, $node.data_map.to_time.content.timestamp)}
                <p>{$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}, ore {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%H.%i' )}</p>*}
            {if and(gt($node.data_map.to_time.content.timestamp, $node.data_map.from_time.content.timestamp), lt(sub($node.data_map.to_time.content.timestamp, $node.data_map.from_time.content.timestamp), 86400 ))}
                <p>{$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )} dalle {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%H.%i' )} alle {$node.data_map.to_time.content.timestamp|datetime( 'custom', '%H.%i' )}</p>
            {else}
                <p>Dal {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )} al {$node.data_map.to_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}</p>
            {/if}
        {else}
            <p>Dal {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}, ore {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%H.%i' )}</p>
        {/if}
    </header>
    <div class="text">
        {*attribute_view_gui attribute=$node|attribute( 'abstract' )*}
        {$node.object.data_map.abstract.content.output.output_text|striptags|shorten(200, '...')}
    </div>
    <footer class="bg-{ezini( 'TypeSettings', $biblio_types[0].id, 'content.ini' )}">
        {include uri='design:parts/target.tpl' item=$node}
        <p>
            <a href="{concat($node.parent.url_alias|ezurl(no), '/(Tipologia)/', $biblio_types[0].data_map.titolo.content)}" class="category initialism">{$biblio_types[0].data_map.titolo.content}</a>
        </p>
    </footer>
</article>

{undef $parent_event_types $types $biblio_types}
