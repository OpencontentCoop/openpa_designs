{def $openpa = object_handler($block)}
{set_defaults(hash('show_title', true(), 'items_per_row', 2))}

{if $block.custom_attributes.layout|eq( 'fixed' )}<div class="container">{/if}
{if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}
<div class="relative carousel-top-control panels-container {if or( $show_title|not(), $block.name|eq('') )}title-placeholder{/if} {$block.view}">

<div class="widget_title">
    {if and( $show_title, $block.name|ne('') )}
        <h3>
    	  {if $openpa.root_node}<a href={$openpa.root_node.url_alias|ezurl()}>{/if}
    	  {$block.name|wash()}
    	  {if $openpa.root_node}</a>{/if}
    	</h3>
    {/if}
</div>

{include uri='design:atoms/carousel.tpl'
         css_id=$block.id
         items=$openpa.content
         root_node=$openpa.root_node
         i_view=panel
         autoplay=0
         image_class=squaremedium
         auto_height=true()
         items_per_row=$items_per_row}
</div>
{unset_defaults(array('show_title','items_per_row'))}
{if is_set($block.custom_attributes.color_style)}</div>{/if}
{if $block.custom_attributes.layout|eq( 'fixed' )}</div>{/if}