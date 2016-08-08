<div class="container">
    {if is_set($block.custom_attributes.color_style)}
    <div class="color color-{$block.custom_attributes.color_style}">{/if}
        <div class="content-view-block block-{$block.view}">

            {if $block.name}
                <h2 class="block-title">{$block.name}</h2>
            {/if}

            {$block.custom_attributes.html}

        </div>
        {if is_set($block.custom_attributes.color_style)}</div>{/if}
</div>