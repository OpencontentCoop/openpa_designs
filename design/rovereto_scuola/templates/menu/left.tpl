{def $home = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}

{def $area_depth = $home.depth|sub(1)}
{def $left_menu_depth = cond( is_set( $pagedata.path_array[$area_depth|sum(1)] ), $area_depth|sum(1), $area_depth ) }

{def $inimenu = openpaini( 'SideMenu', 'IdentificatoriMenu', array() )     
     $parent_node = fetch(content, node, hash(node_id, $current_node_id))
     $left_menu_root_url = cond( $pagedata.path_array[$left_menu_depth].url_alias, $pagedata.path_array[$left_menu_depth].url_alias, $requested_uri_string )}

    <nav class="menu-left">
    <div class="collapse navbar-collapse navbar-ex1-collapse">    	
    {def $root_node=fetch( 'content', 'node', hash( 'node_id', $pagedata.path_array[$left_menu_depth].node_id ) )}
    
    {def $left_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                            'sort_by', $root_node.sort_array,
                                                            'data_map_load', false(),
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $inimenu ) )
         $left_menu_items_count = $left_menu_items|count()
         $li_class = array()
		 $li_class3 = array()
		 $li_class4 = array()
         $a_class = array()
		 $a_class3 = array()
		 $a_class4 = array()
         $current_node_in_path_2 = first_set( $pagedata.path_array[$left_menu_depth|inc].node_id,  0 )
         $current_node_in_path_3 = first_set( $pagedata.path_array[$left_menu_depth|sum(2)].node_id,  0 )
         $current_node_in_path_4 = first_set( $pagedata.path_array[$left_menu_depth|sum(3)].node_id,  0 )
         $current_node_in_path_5 = first_set( $pagedata.path_array[$left_menu_depth|sum(4)].node_id,  0 )}

	{if $left_menu_items_count}
        <ul class="menu-list">
        {foreach $left_menu_items as $key => $item}
        {if openpaini( 'SideMenu', 'NascondiNodi', array() )|contains( $item.node_id )|not()}
            {set $a_class = cond($current_node_in_path_2|eq($item.node_id), array("selected"), array())
                 $li_class = cond( $key|eq(0), array("firstli"), array() )}

            {if $left_menu_items_count|eq( $key|inc )}
                {set $li_class = $li_class|append("lastli")}
            {/if}
            {if $item.node_id|eq( $current_node_id )}
                {set $a_class = $a_class|append("current")}
            {/if}
            {if and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                <li{if $li_class} class="{$li_class|implode(" ")}"{/if}>
					<a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href="{$item.data_map.location.content}"{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$item.data_map.location.data_text|wash}" class="menu-item-link" rel={$item.url_alias|ezurl}>
						<span>{$item.name|wash()}</span>
					</a>				
            {else}
                <li{if $li_class} class="{$li_class|implode(" ")}"{/if}>
                    <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{if $item.node_id|eq($item.main_node_id)}{$item.url_alias|ezurl}{else}{if $item.class_identifier|eq('area_tematica')}{$item.object.main_node.url_alias|ezurl}{else}{$item.url_alias|ezurl}{/if}{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>
                        <span>{$item.name|wash()}</span>
                    </a>
            {/if}

            {if or( eq( $current_node_in_path_2, $item.node_id ), openpaini( 'SideMenu', 'UsaMenuEsteso', 'enabled' )|eq( 'enabled' ) )}
                {def $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id, 'sort_by', $item.sort_array, 'data_map_load', false(),
                                                                      'class_filter_type', 'include', 'class_filter_array', $inimenu ) )
                     $sub_menu_items_count = $sub_menu_items|count}
                {if $sub_menu_items_count}
                <ul class="sub-menu-list">
                    {foreach $sub_menu_items as $subkey => $subitem}
                    {if openpaini( 'SideMenu', 'NascondiNodi', array() )|contains( $subitem.node_id )|not()}   	
                        {set $a_class = cond($current_node_in_path_3|eq($subitem.node_id), array("selected"), array())  $li_class = cond( $subkey|eq(0), array("firstli"), array() )}
                    	{if $sub_menu_items_count|eq( $subkey|inc )} {set $li_class = $li_class|append("lastli")} {/if}
                    	{if $subitem.node_id|eq( $current_node_id )} {set $a_class = $a_class|append("current")} {/if}
                    	<li{if $li_class} class="{$li_class|implode(" ")}"{/if}>
								{if and( is_set( $subitem.data_map.location ), $subitem.data_map.location.has_content )}
                                    <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}"{$subitem.data_map.location.content}"{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>
									<span>{$subitem.name|wash()}</span>
								</a>
                                {else}
                                    <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{if $subitem.node_id|eq($subitem.main_node_id)}{$subitem.url_alias|ezurl}{else}{if $subitem.class_identifier|eq('area_tematica')}{$subitem.object.main_node.url_alias|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>
									<span>{$subitem.name|wash()}</span>
								</a>
                                {/if}
                        {* start terzo livello  *}
                                {if eq( $current_node_in_path_3, $subitem.node_id )}
                                {def $sub_menu_items3 = fetch( 'content', 'list', hash( 'parent_node_id', $subitem.node_id, 'sort_by', $subitem.sort_array, 'data_map_load', false(),
                                                                                  'class_filter_type', 'include', 'class_filter_array', $inimenu ) )
                                         $sub_menu_items_count3 = $sub_menu_items3|count}
                                    {if $sub_menu_items_count3} 
                                        <ul class="sub-sub-menu-list">
                                            {foreach $sub_menu_items3 as $subkey3 => $subitem3}
                                            {if openpaini( 'SideMenu', 'NascondiNodi', array() )|contains( $subitem3.node_id )|not()}
                                                {set $a_class3 = cond($current_node_in_path_4|eq($subitem3.node_id), array("selected"), array())  $li_class3 = cond( $subkey3|eq(0), array("firstli"), array() )}
                                                {if $sub_menu_items_count3|eq( $subkey|inc )} {set $li_class3 = $li_class3|append("lastli")} {/if}
                                                {if $subitem3.node_id|eq( $current_node_id )} {set $a_class3 = $a_class3|append("current")}{/if}
                                                    <li{if $li_class3} class="{$li_class3|implode(" ")}"{/if}>
                                                        <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem3.node_id)|ezurl}{else}{if $subitem3.node_id|eq($subitem3.main_node_id)}{$subitem3.url_alias|ezurl}{else}{if $subitem3.class_identifier|eq('area_tematica')}{$subitem3.object.main_node.url_alias|ezurl}{else}{$subitem3.url_alias|ezurl}{/if}{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}{if $a_class3} class="{$a_class3|implode(" ")}"{/if}>
                                                            <span>{$subitem3.name|wash()}</span>
                                                        </a>
                        {* start quarto livello  *}
                                    {if eq( $current_node_in_path_4, $subitem3.node_id )}
                                    {def $sub_menu_items4 = fetch( 'content', 'list', 
                                                hash( 'parent_node_id', $subitem3.node_id, 'sort_by', $subitem3.sort_array, 'data_map_load', false(),
                                                                                    'class_filter_type', 'include', 'class_filter_array', $inimenu ) )
                                                 $sub_menu_items_count4 = $sub_menu_items4|count}
                                            {if $sub_menu_items_count4}
                                            <ul class="submenu-list-4">
                                                {foreach $sub_menu_items4 as $subkey4 => $subitem4}
                                                {if openpaini( 'SideMenu', 'NascondiNodi', array() )|contains( $subitem4.node_id )|not()}
                                                    {set $a_class4 = cond($current_node_in_path_5|eq($subitem4.node_id), array("selected"), array())  $li_class4 = cond( $subkey4|eq(0), array("firstli"), array() )}
                                                    {if $sub_menu_items_count4|eq( $subkey|inc )} {set $li_class4 = $li_class4|append("lastli")} {/if}
                                                    {if $subitem4.node_id|eq( $current_node_id )} {set $a_class4 = $a_class4|append("current")}{/if}
                                                    {if $subitem4.node_id|eq( $parent_node.parent_node_id )} {set $a_class4 = $a_class4|append("selected")}{/if}
                                                    <li{if $li_class4} class="{$li_class4|implode(' ')}"{/if}>
                                                        <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem4.node_id)|ezurl}{else}{if $subitem4.node_id|eq($subitem4.main_node_id)}{$subitem4.url_alias|ezurl}{else}{if $subitem4.class_identifier|eq('area_tematica')}{$subitem4.object.main_node.url_alias|ezurl}{else}{$subitem4.url_alias|ezurl}{/if}{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}{if $a_class4} class="{$a_class4|implode(' ')}"{/if}>
                                                            <span>{$subitem4.name|wash()}</span>
                                                        </a>
                                            </li>
                                                {/if}
                                                {/foreach}
                                            </ul>
                                            {/if}
                                    {undef $sub_menu_items4 $sub_menu_items_count4}
                                    {/if}
                        {* end quarto livello  *}
                                    </li>
                                            {/if}
                                            {/foreach}
                                        </ul>
                                    {/if}
                                {undef $sub_menu_items3 $sub_menu_items_count3}
                                {/if}
                        {* end terzo livello  *}
                        
                        </li>
                    {/if}
                    {/foreach}
                </ul>
                {/if}
            {undef $sub_menu_items $sub_menu_items_count}
            {/if}
            </li>
        {/if}
        {/foreach}
        </ul>
    {/if}
    {undef $root_node $left_menu_items $left_menu_items_count $a_class $li_class $current_node_in_path_2 $current_node_in_path_3}
    </div>
    </nav>

{undef $left_menu_root_url $left_menu_depth}

{undef}