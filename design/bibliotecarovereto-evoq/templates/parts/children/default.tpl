{set_defaults( hash(
  'page_limit', 10,
  'view', 'line',
  'delimiter', '',
  'exclude_classes', array(),
  'include_classes', array(),
  'type', 'exclude',
  'fetch_type', 'list',
  'parent_node', $node
))}

{if $type|eq( 'exclude' )}
{def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
{elseif $include_classes|count()|gt(0)}
{def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
{else}
{def $params = hash()}
{/if}

{def $children_count = fetch( content, concat( $fetch_type, '_count' ), hash( 'parent_node_id', $parent_node.node_id )|merge( $params ) )
     $counter = 1}
{if $children_count}

            <ul class="row list-unstyled list-boxed">
                {foreach fetch( content, $fetch_type, hash( 'parent_node_id', $parent_node.node_id,
                                            'offset', $view_parameters.offset,
                                            'sort_by', $parent_node.sort_array,
                                            'limit', $page_limit )|merge( $params ) ) as $child }
                    <li class="col-xs-12 col-md-6 col-lg-6 item">
                        {node_view_gui view=$view content_node=$child}
                    </li>
                    {delimiter}{$delimiter}{/delimiter}
                    {if eq($counter|mod(2), 0)}
                        <li class="col-md-12 spacer"></li>
                    {/if}
                    {set $counter = $counter|sum(1) }
                {/foreach}
            </ul><!-- /.row -->


            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$children_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}
{/if}
