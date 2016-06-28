{def $openpa= object_handler($block)}
{set_defaults(hash('show_title', true()))}

{if $block.custom_attributes.layout|eq( 'fixed' )}<div class="container">{/if}
{if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}
{if and( $show_title, $block.name|ne('') )}
<div class="widget_title">
    <h3><a href={$openpa.root_node.url_alias|ezurl()}>{$block.name|wash()}</a></h3>
</div>
<div class="widget">
{/if}
    <div class="{if and( $show_title, $block.name|ne('') )}widget_content {/if}carousel-both-control">
        {include name="carousel"
		  uri='design:atoms/carousel.tpl'
		  items=$openpa.content
		  css_id=$block.id
		  root_node=$openpa.root_node
		  autoplay=10000
		  pagination=true()
		  navigation= false()
		  items_per_row=1}
    </div>

{if and( $show_title, $block.name|ne('') )}
</div>
{/if}
{if is_set($block.custom_attributes.color_style)}</div>{/if}
{if $block.custom_attributes.layout|eq( 'fixed' )}</div>{/if}
{unset_defaults(array('show_title'))}