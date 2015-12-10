{def $valid_node = $block.valid_nodes[0]}
{if $valid_node}
{def $url = $valid_node.url_alias|ezurl()}
{if and( is_set( $valid_node.data_map.location ), $valid_node.data_map.location.has_content )}
    {set $url = concat( '"', $valid_node.data_map.location.content, '"')}
{/if}

<div class="ezpage-block overlay {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">

    <h3 class="overlay">
        <a href={$url} title="Link a {$valid_node.name|wash()}">{$valid_node.name|wash()}</a>
    </h3>
    
    {if and( is_set($valid_node.data_map.image), $valid_node.data_map.image.has_content )}
    {attribute_view_gui alt=$valid_node.name|wash() attribute=$valid_node.data_map.image image_class='evoq_singolo_img' href=$url}
    {/if}
</div>

{undef $url}
{/if}