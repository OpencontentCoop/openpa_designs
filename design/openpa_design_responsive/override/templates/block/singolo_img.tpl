{def $valid_node = $block.valid_nodes[0]}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
    {attribute_view_gui alt=$valid_node.name|wash() attribute=$valid_node.data_map.image image_class='singolo'}
</div>
