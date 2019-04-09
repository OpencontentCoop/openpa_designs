{* Image - Full view *}

{def $sort_order=$node.parent.sort_array[0][1]
     $sort_column=$node.parent.sort_array[0][0]
     $sort_column_value=cond( $sort_column|eq( 'published' ), $node.object.published,
                        $sort_column|eq( 'modified' ), $node.object.modified,
                        $sort_column|eq( 'name' ), $node.object.name,
                        $sort_column|eq( 'priority' ), $node.priority,
                        $sort_column|eq( 'modified_subnode' ), $node.modified_subnode,
                        false() ) }
{if $sort_column_value|eq( false() )}
    {set $sort_column_value = $node.object.published
         $sort_column = 'published'}
{/if}

{def $previous_image = fetch( 'content', 'list', hash( 'parent_node_id', $node.parent_node_id,
                                                       'class_filter_type', 'include',
                                                       'class_filter_array', array( 'image' ),
                                                       'limit', '1',
                                                       'attribute_filter', array( 'and', array( $sort_column, $sort_order|choose( '>', '<' ), $sort_column_value ) ),
                                                       'sort_by', array( array( $sort_column, $sort_order|not ), array( 'node_id', $sort_order|not ) ) ) )
     $next_image = fetch( 'content', 'list', hash( 'parent_node_id', $node.parent_node_id,
                                                   'class_filter_type', 'include',
                                                   'class_filter_array', array( 'image' ),
                                                   'limit', '1',
                                                   'attribute_filter', array( 'and', array( $sort_column, $sort_order|choose( '<', '>' ), $sort_column_value ) ),
                                                   'sort_by', array( array( $sort_column, $sort_order ), array( 'node_id', $sort_order ) ) ) ) }

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">    

        <h1>{$node.name|wash()}</h1>

        {if is_unset( $versionview_mode )}
        <ul class="pager">
            {if $previous_image}
                <li class="previous">
					<a href={$previous_image[0].url_alias|ezurl} title="{$previous_image[0].name|wash}">Precedente</a>
                </li>
            {else}
                <li class="previous disabled">
					<span>Precedente</span>
                </li>
            {/if}
            
            {def $parent=$node.parent}
                <li><a href={$parent.url_alias|ezurl}>{$parent.name|wash}</a></li>

            

            {if $next_image}
                <li class="next">
                    <a href={$next_image[0].url_alias|ezurl} title="{$next_image[0].name|wash}">Successiva</a>
                </li>
            {else}
                <li class="next disabled">
                    <span>Successiva</span>
                </li>
            {/if}
        </ul>
        {/if}

        <div class="attribute-image">
            <p class="text-center">{attribute_view_gui attribute=$node.data_map.image image_class=imagelarge}</p>
        </div>

        <div class="attribute-caption">
            {attribute_view_gui attribute=$node.data_map.caption}
        </div>


    </div>
</div>

</div>
</div>