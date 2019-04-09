{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}
{* EDITOR TOOLS *}
{include name = editor_tools
         node = $node             
         uri = 'design:parts/openpa/editor_tools.tpl'}
<div class="row-fp">
    {if $node.object.data_map.page.has_content}
        {attribute_view_gui attribute=$node.object.data_map.page}
    {else}
        {def $classes =  openpaini( 'ExcludedClassesAsChild', 'FromFolder' )
             $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 20 )
             $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
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
    {/if}
</div>
