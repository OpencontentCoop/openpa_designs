{def $valid_node = $block.valid_nodes[0]}

{def $url = $valid_node.url_alias|ezurl()}
{if and( is_set( $valid_node.data_map.location ), $valid_node.data_map.location.has_content )}
    {set $url = concat( '"', $valid_node.data_map.location.content, '"')}
{/if}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">    
    <h2><a href={$url} title="Link a {$valid_node.name|wash()}">{$valid_node.name|wash()}</a></h2>
    {if $valid_node|has_abstract()}
        
        <p>
            {if and( is_set( $valid_node.data_map.periodo_svolgimento ), $valid_node.data_map.periodo_svolgimento.has_content )}
            <strong>{$valid_node.data_map.periodo_svolgimento.content|wash()}</strong> <br />
            {elseif $valid_node.class_identifier|eq('avviso')}
            <strong>{$valid_node.object.published|datetime( "custom", "%j %F %Y")|downcase()}</strong> -
            {/if}
            {$valid_node|abstract()|openpa_shorten(400)}
        </p>
        
        <p class="link"><a href={$url} title="Dettagli di {$valid_node.name|wash()}">VEDI DETTAGLI</a></p>
    {/if}
</div>

{undef $url}