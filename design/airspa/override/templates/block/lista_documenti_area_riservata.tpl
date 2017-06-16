
{def $openpa= object_handler($block)}
{set_defaults(hash('show_title', true()))}

{if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}

{if and( $show_title, $block.name|ne('') )}
 <div class="widget_title">
        <h3><a href={$openpa.root_node.url_alias|ezurl()}>{$block.name|wash()}</a></h3>
    </div>
<div class="widget {$block.view}">
    <div class="widget_content">
{/if}

{def $__LIST_DOC = fetch( 'content', 'tree', hash( 'parent_node_id', $block.custom_attributes.node_id,
                                                'class_filter_type', 'include',
                                                'class_filter_array', $block.custom_attributes.includi_classi|explode( ',' ),
                                                'depth', $block.custom_attributes.livello_profondita,
                                                'limit', $block.custom_attributes.limite,
                                                'sort_by', $sort_array) )}

{foreach $__LIST_DOC as $item}
    {node_view_gui content_node=$item view=line image_class=small}
{/foreach}

{*{$__LIST_DOC|attribute(show)}*}

{if and( $show_title, $block.name|ne('') )}
  </div>
</div>
{/if}
{if is_set($block.custom_attributes.color_style)}</div>{/if}