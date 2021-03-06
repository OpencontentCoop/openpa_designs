{def $left_menu_depth = count($pagedata.path_array)|gt(1)|choose( 0, 1 )}
{if and( $left_menu_depth|eq(1), $pagedata.path_array[0].node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}  
  {set $left_menu_depth = 0}  
{/if}
{if is_area_tematica()}
  {set $left_menu_depth = inc( $left_menu_depth )}
{/if}
{def $left_menu_root_node = $pagedata.path_array[$left_menu_depth]
     $left_menu_root_url = cond( $pagedata.path_array[$left_menu_depth].url_alias, $pagedata.path_array[$left_menu_depth].url_alias, $requested_uri_string )
     $root_node = fetch( content, node, hash( node_id, $left_menu_root_node.node_id ) )}

{def $top_menu_ids = openpaini( 'TopMenu', 'NodiCustomMenu', array() )}
{foreach $pagedata.path_array as $path}
  {if $top_menu_ids|contains($path.node_id)}
    {set $root_node = fetch( content, node, hash( node_id, $path.node_id ) )}
    {break}
  {/if}
{/foreach}

{ezscript_require( array( 'ezjsc::jquery', 'ezjsc::jqueryio', 'ajaxmenu.js', 'cachedmenu.js' ) )}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

    <h2 class="hide">Menu di navigazione</h2>

    {if is_area_tematica()}        
        {left_menu_cached( hash( 'root_node_id', is_area_tematica().node_id, 'user_hash', $user_hash ) )}
    {else}
        {def $custom_templates_classes = openpaini( 'SideMenu', 'CachedMenuCustomTemplateClassi', array() )
             $custom_templates_nodes = openpaini( 'SideMenu', 'CachedMenuCustomTemplateNodi', array() )}
        {if is_set( $custom_templates_classes[$root_node.class_identifier] )}
            {left_menu_cached( hash( 'root_node_id', $root_node.node_id, 'template', $custom_templates_classes[$root_node.class_identifier] ) )}
        {elseif is_set( $custom_templates_nodes[$root_node.node_id] )}
            {left_menu_cached( hash( 'root_node_id', $root_node.node_id, 'template', $custom_templates_nodes[$root_node.node_id] ) )}
        {else}
            {left_menu_cached( hash( 'root_node_id', $root_node.node_id ) )}
        {/if}
    {/if}

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
