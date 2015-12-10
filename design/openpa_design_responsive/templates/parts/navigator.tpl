{def $previous_node = fetch( 'content', 'list', hash( 'parent_node_id', $node.parent_node_id,
                                                       'limit', '1',
                                                       'attribute_filter', array( 'and', array( $sort_column, $sort_order|choose( '>', '<' ), $sort_column_value ) ),
                                                       'sort_by', array( array( $sort_column, $sort_order|not ), array( 'node_id', $sort_order|not ) ) ) )
     $next_node = fetch( 'content', 'list', hash( 'parent_node_id', $node.parent_node_id,
                                                   'limit', '1',
                                                   'attribute_filter', array( 'and', array( $sort_column, $sort_order|choose( '<', '>' ), $sort_column_value ) ),
                                                   'sort_by', array( array( $sort_column, $sort_order ), array( 'node_id', $sort_order ) ) ) ) }


<ul class="pager">
    {if $previous_node}
        <li class="previous">
            <a href={$previous_node[0].url_alias|ezurl} title="{$previous_node[0].name|wash}">Precedente</a>
        </li>
    {else}
        <li class="previous disabled">
            <span>Precedente</span>
        </li>
    {/if}
    
    {def $parent=$node.parent}
        <li><a href={$parent.url_alias|ezurl}>{$parent.name|wash}</a></li>

    

    {if $next_node}
        <li class="next">
            <a href={$next_node[0].url_alias|ezurl} title="{$next_node[0].name|wash}">Successiva</a>
        </li>
    {else}
        <li class="next disabled">
            <span>Successiva</span>
        </li>
    {/if}
</ul>
