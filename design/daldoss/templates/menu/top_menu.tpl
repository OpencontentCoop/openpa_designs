{def $top_menu_node_ids = openpaini( 'TopMenu', 'NodiCustomMenu', array() )}
{def $top_menu_node_ids_count = $top_menu_node_ids|count()}

{def $main_styles = openpaini( 'Stili', 'Nodo_NomeStile', array() )}
{def $item_class = "no-main-style"}

<ul class="nav navbar-nav navbar-right collapse navbar-collapse" id="main-navbar">

    <li class="toplevel firstli {if $current_node_id|eq(ezini( 'NodeSettings', 'RootNode', 'content.ini' ))}current{/if}">
        <a title="Link a homepage" href={'/'|ezurl()}>
            <i class="fa fa-home" aria-hidden="true"></i> Home
        </a>
    </li>

    {if $top_menu_node_ids_count}
        {foreach $top_menu_node_ids as $id}
            {def $tree_menu = tree_menu( hash( 'root_node_id', $id, 'scope', 'top_menu'))}

            {set $item_class = "no-main-style"}
            {foreach $main_styles as $style}
                {set $style = $style|explode(';')}
                {if $style[0]|eq($tree_menu.item.node_id)}
                    {set $item_class =  $style[1]|slugize()}
                    {break}
                {/if}
            {/foreach}

            <li class="{$item_class}{if $tree_menu.has_children} dropdown yamm-fw toplevel{/if}">
                {include
                    recursion=0
                    name=top_menu
                    uri='design:menu/top_menu_item.tpl'
                    menu_item=$tree_menu current=or($tree_menu.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($tree_menu.item.node_id))}
                {if $tree_menu.has_children}
                <ul class="dropdown-menu">
                    <li>
                        <div class="yamm-content">
                            {if $tree_menu.max_recursion|eq(1)}
                                <div class="row">
                                    <div class="col-xs-12">
                                        <ul class="sub_menu list-unstyled no_sub_level">
                                            {foreach $tree_menu.children as $child}
                                            <li>
                                                {include
                                                    recursion=1
                                                    name="top_sub_menu" uri='design:menu/top_menu_item.tpl'
                                                    menu_item=$child
                                                    current=or($tree_menu.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($tree_menu.item.node_id))}
                                            </li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            {else}
                                <div class="row">
                                    {def $col = 3 $modulo = 4 $children_count = count($tree_menu.children)}
                                    {if $children_count|eq(3)} {set $col = 4 $modulo = 3}
                                    {elseif $children_count|eq(2)} {set $col = 6 $modulo = 2}
                                    {elseif $children_count|eq(1)} {set $col = 12 $modulo = 1}
                                    {/if}
                                    {foreach $tree_menu.children as $child}
                                        <div class="col-xs-12 col-sm-{$col}">
                                                <b>{include
                                                        recursion=2
                                                        name="top_sub_menu"
                                                        uri='design:menu/top_menu_item.tpl'
                                                        menu_item=$child
                                                        current=or($tree_menu.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($tree_menu.item.node_id))}
                                                </b>
                                                <ul class="sub_menu list-unstyled{if $child.has_children|not()} no_sub_level{/if}">
                                                {if $child.has_children}
                                                    {foreach $child.children as $sub_child max 10}
                                                        <li>{include
                                                                recursion=3
                                                                name="top_sub_menu"
                                                                uri='design:menu/top_menu_item.tpl'
                                                                menu_item=$sub_child
                                                                current=or($tree_menu.item.node_id|eq($current_node_id), $pagedata.path_id_array|contains($tree_menu.item.node_id))}
                                                        </li>
                                                    {/foreach}
                                                {/if}
                                            </ul>
                                        </div>
                                        {delimiter modulo=$modulo}</div><div class="row">{/delimiter}
                                    {/foreach}
                                    {undef $col $modulo $children_count}
                                </div>
                            {/if}
                        </div>
                    </li>
                </ul>
                {/if}
            </li>
            {undef $tree_menu}
        {/foreach}
    {/if}

</ul>
