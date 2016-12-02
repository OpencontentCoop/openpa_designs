{def $root_node=fetch( 'content', 'node', hash( 'node_id', 2 ) )}
{set_defaults(hash('show_title', true()))}

{def $t = fetch( tags, tags_by_keyword, hash( keyword, $block.custom_attributes.tag|upcase() ) )}

{if $t|count}

    {def $tag_id=$t[0].id}

    {def $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
    extended_attribute_filter,
    hash( id, TagsAttributeFilter,
    params, hash( tag_id, $tag_id, include_synonyms, true() ) ),
    offset, first_set( $view_parameters.offset, 0 ),
    limit, $block.custom_attributes.limite,
    main_node_only, true(),
    sort_by, array( published, false() ) ) )}

    {def $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
    extended_attribute_filter,
    hash( id, TagsAttributeFilter,
    params, hash( tag_id, $tag_id, include_synonyms, true() ) ),
    main_node_only, true() ) )}

    {*if $nodes|count}
        {foreach $nodes as $child }
            <div class="class-pagina_sito media ">
                {node_view_gui content_node=$child view=line}
            </div>
        {/foreach}
        {undef $limit $nodes $nodes_count}
    {/if*}


    {if $block.custom_attributes.layout|eq( 'fixed' )}<div class="container">{/if}

    <div class="{if and( $show_title, $block.name|ne('') )}widget_content {/if}carousel-both-control">
        {include name="carousel"
        uri='design:atoms/carousel.tpl'
        items=$nodes
        css_id=$block.id
        root_node=$root_node
        autoplay=10000
        pagination=true()
        navigation= false()
        items_per_row=1}
    </div>
    {if $block.custom_attributes.layout|eq( 'fixed' )}</div>{/if}
{/if}

{unset_defaults(array('show_title'))}
