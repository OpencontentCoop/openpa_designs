{def $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 20 )
     $classes = openpaini( 'ExcludedClassesAsChild', 'FromFolder' )
     $children = array()
     $gallery = false()
     $children_count = 0}


{set $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                 'offset', $view_parameters.offset,
                                                 'sort_by', $node.sort_array,
                                                 'class_filter_type', 'exclude',
                                                 'class_filter_array', $classes,
                                                 'limit', $page_limit ) )
     $children_count=fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                           'class_filter_type', 'exclude',
                                                           'class_filter_array', $classes ) )}
{if $children_count|gt(0)}
    {foreach $children as $child }                
        {node_view_gui view='line' show_image='no' content_node=$child}
    {/foreach}
    {include name=navigator
             uri='design:navigator/google.tpl'
             page_uri=$node.url_alias
             item_count=$children_count
             view_parameters=$view_parameters
             item_limit=$page_limit}
{/if}


{set $gallery=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                               'offset', $view_parameters.offset,
                                               'sort_by', $node.sort_array,
                                               'class_filter_type', 'include',
                                               'class_filter_array', array('image'),
                                               'limit', $page_limit ) )}
{if $gallery|count()|gt(0)}
    {node_view_gui view='line_gallery' content_node=$node}
{/if}

{* in caso di gallerie fotografiche *}
{set $children=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                 'offset', $view_parameters.offset,
                                                 'sort_by', $node.sort_array,
                                                 'class_filter_type', 'include',
                                                 'class_filter_array', array('gallery'),
                                                 'limit', $page_limit ) )}
{if $children|count()|gt(0)}
   {set $style='col-odd'}
   {foreach $children as $child }                    
       {node_view_gui view='line_gallery' content_node=$child}                    
   {/foreach}
{/if}