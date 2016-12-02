{if or( openpaini( 'ExtraMenu', 'NascondiNeiNodi', array( 0 ) )|contains($node.node_id), openpaini( 'ExtraMenu', 'NascondiNelleClassi', array( 0 ) )|contains($node.class_identifier), openpaini( 'ExtraMenu', 'Nascondi', false() ) )}
    {ezpagedata_set( 'extra_menu', false() )}
{elseif $node.parent.class_identifier|eq( 'newsletter' )}
    {ezpagedata_set( 'extra_menu', 'extra_info_newsletter' )}
{/if}

{if or( openpaini( 'SideMenu', 'NascondiNeiNodi', array( 0 ) )|contains($node.node_id), openpaini( 'SideMenu', 'NascondiNelleClassi', array( 0 ) )|contains($node.class_identifier) )}
	{ezpagedata_set( 'left_menu', false() )}
{/if}

{if is_area_tematica()}
    
    {ezpagedata_set( 'top_menu', true() )}
    {if is_set( is_area_tematica().data_map.top_menu )}
        {if is_area_tematica().data_map.top_menu.content|eq(1)}
            {ezpagedata_set( 'top_menu', true() )}
        {else}
            {ezpagedata_set( 'top_menu', false() )}
        {/if}
    {/if}
    
    {if is_set( is_area_tematica().data_map.left_menu )}
        {if and( is_area_tematica().data_map.left_menu.content|eq(1), $node.node_id|ne( is_area_tematica().node_id ) )}
            {ezpagedata_set( 'left_menu', true() )}
        {else}
            {ezpagedata_set( 'left_menu', false() )}
        {/if}
    {/if}
    
    {if is_set( is_area_tematica().data_map.extra_menu )}
        {if is_area_tematica().data_map.extra_menu.content|eq(1)}
            {ezpagedata_set( 'extra_menu', true() )}
        {else}
            {ezpagedata_set( 'extra_menu', false() )}
        {/if}
    {/if}
    
    {if is_set( is_area_tematica().data_map.show_path )}
        {if is_area_tematica().data_map.show_path.content|eq(1)}
            {ezpagedata_set( 'show_path', true() )}
        {else}
            {ezpagedata_set( 'show_path', false() )}
        {/if}
    {/if}

{/if}