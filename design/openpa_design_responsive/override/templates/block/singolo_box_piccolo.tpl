{def $valid_node = $block.valid_nodes[0]}
<div class="ezpage-block row {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
    {if $block.name}<h2>{$block.name}</h2>{/if}
    <div class="col-md-3">
        {if and( is_set($valid_node.data_map.image), $valid_node.data_map.image.has_content )}
        {attribute_view_gui href=$valid_node.url_alias|ezurl() alt=$valid_node.name|wash() attribute=$valid_node.data_map.image image_class='ezflowmediablock' }
        {/if}
    </div>
    <div class="col-md-9">
        <h3><a href={$valid_node.url_alias|ezurl()}>{$valid_node.name|wash()}</a></h3>
    </div>
</div>    
