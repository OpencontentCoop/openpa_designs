{default attribute_parameters=array()}
	{section show=$object.main_node_id|null|not}
        {if and( is_set( $object.data_map.location ), $object.data_map.location.has_content )}
            <a href="{$object.data_map.location.content}"{if and( is_set( $object.data_map.open_in_new_window ), $object.data_map.open_in_new_window.data_int )} target="_blank"{/if}>{$object.name|wash}</a>
        {else}
            <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
        {/if}
	{section-else}
	    {$object.name|wash}
	{/section}
{/default}

