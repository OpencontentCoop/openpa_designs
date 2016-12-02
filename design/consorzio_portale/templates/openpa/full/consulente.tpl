{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>
    </div>

    {if $openpa.control_menu.show_side_menu}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if $openpa.control_menu.show_side_menu|not()} wide{/if}">

        {include uri=$openpa.content_main.template}

        {include uri=$openpa.content_detail.template}

        {include uri=$openpa.content_infocollection.template}

        {include uri=$openpa.control_children.template}

    </div>


</div>
