{def $limit = 10
     $page_uri = concat('/', $node.path_with_names)}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


{def $links = fetch( 'content', 'list',
        hash( 'parent_node_id', $node.node_id,
'class_filter_type',  'include',
'class_filter_array', array( 'link' ),
'sort_by',        array( array( 'name',      true() ),
array( 'published', false() ) )) )}

{if $node.data_map.page.has_content}
    {attribute_view_gui attribute=$node.data_map.page}
{/if}
<div class="content-view-full class-{$node.class_identifier} row">
    <div class="container">
        {if $show_left}
        {*<div class="content-title">
            {include uri='design:openpa/full/parts/node_languages.tpl'}
            <h1>{$node.name|wash()}</h1>
        </div>*}

            {include uri='design:openpa/full/parts/section_left.tpl'}
        {/if}

        <div class="content-main{if $links|count()|gt(0)}  full-stack{/if}">

            <h1>{$node.name|wash()}</h1>

            {attribute_view_gui attribute=$node|attribute( 'abstract' )}
            <hr />

            {include uri=$openpa.control_children.template}

                {def $t = fetch( tags, tags_by_keyword, hash( keyword, $node|attribute( 'short_name' ).content|upcase() ) )}

                {if $t|count}

                    {def $tag_id=$t[0].id}

                    {def $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                    extended_attribute_filter,
                    hash( id, TagsAttributeFilter,
                    params, hash( tag_id, $tag_id, include_synonyms, true() ) ),
                    offset, first_set( $view_parameters.offset, 0 ),
                    limit, $limit,
                    main_node_only, true(),
                    sort_by, array( published, false() ) ) )}

                    {def $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                    extended_attribute_filter,
                    hash( id, TagsAttributeFilter,
                    params, hash( tag_id, $tag_id, include_synonyms, true() ) ),
                    main_node_only, true() ) )}

                    {if $nodes|count}
                        {foreach $nodes as $child }
                            <div class="class-pagina_sito media ">
                                {node_view_gui content_node=$child view=line}
                            </div>
                        {/foreach}

                        {include uri='design:navigator/google.tpl'
                        page_uri=$page_uri
                        item_count=$nodes_count
                        view_parameters=$view_parameters
                        item_limit=$limit}

                        {undef $limit $nodes $nodes_count}
                    {/if}

                {/if}
        </div>
        <br />
        {if $links|count()|gt(0)}
            <div class="content-related">
                <h4><i class="fa fa-external-link" aria-hidden="true"></i> Link</h4>
                {foreach $links as $l }
                    {node_view_gui content_node=$l view=line}
                {/foreach}
            </div>
        {/if}
    </div>
</div>