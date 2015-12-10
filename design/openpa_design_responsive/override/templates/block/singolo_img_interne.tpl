{def $valid_node = $block.valid_nodes[0]}


<div class="ezpage-block overlay {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
    <h2 class="overlay">
        <a href={$valid_node.url_alias|ezurl()} title="Link a {$valid_node.name|wash()}">{if $block.name}{$block.name}{else}{$valid_node.name|wash()}{/if}</a>
    </h2>
    {if and( is_set($valid_node.data_map.image), $valid_node.data_map.image.has_content )}
    {attribute_view_gui alt=$valid_node.name|wash() attribute=$valid_node.data_map.image image_class=large}
    {/if}
</div>

