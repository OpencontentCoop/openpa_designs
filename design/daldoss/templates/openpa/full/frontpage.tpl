{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}

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

        <div class="content-main{if $show_left|not()} wide{/if}">

          <h1>{$node.name|wash()}</h1>

            {include uri=$openpa.control_children.template}
        </div>
    </div>
</div>