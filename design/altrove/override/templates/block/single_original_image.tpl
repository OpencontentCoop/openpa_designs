{def $__VIEW_IMAGE = 'original'}

{def $__IMAGE = fetch('content','node',hash('node_id',$block.last_valid_item.node_id))}

<div class="thumbnail">
    <img src={$__IMAGE.data_map.image.content[$__VIEW_IMAGE].url|ezroot()} alt="{$__IMAGE.data_map.image.content.alternative_text|wash()}" />
</div>

