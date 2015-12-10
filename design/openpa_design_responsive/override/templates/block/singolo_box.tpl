{def $valid_node = $block.valid_nodes[0]}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
    {if and( is_set($valid_node.data_map.image), $valid_node.data_map.image.has_content )}
    {attribute_view_gui href=$valid_node.url_alias|ezurl() alt=$valid_node.name|wash() attribute=$valid_node.data_map.image image_class='large' }
    {/if}
    <h2><a href={$valid_node.url_alias|ezurl()} title="Link a {$valid_node.name|wash()}">{$valid_node.name|wash()}</a></h2>
    {if $valid_node|has_abstract()}
        {$valid_node|abstract()}
        <p><a href={$valid_node.url_alias|ezurl()} title="Dettagli di {$valid_node.name|wash()}">> DETTAGLI DELLA NEWS</a></p>
    {/if}
</div>