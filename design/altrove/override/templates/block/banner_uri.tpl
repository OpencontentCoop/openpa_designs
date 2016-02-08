{def $__VIEW_IMAGE = 'small'}

{def $__IMAGE = fetch('content','node',hash('node_id',$block.last_valid_item.node_id))}
{def $__URI = $block.custom_attributes.uri}

{if $__URI|ne('')}
    <a href="{$__URI}" target="_blank">
{/if}

    <img src={$__IMAGE.data_map.image.content[$__VIEW_IMAGE].url|ezroot()} alt="{$__IMAGE.data_map.image.content.alternative_text|wash()}" />

{if $__URI|ne('')}
    </a>
{/if}
{*
{$block|attribute(show)}*}