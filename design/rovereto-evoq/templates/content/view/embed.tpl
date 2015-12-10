{default attribute_parameters=array()}
	{if and( $object.main_node_id|null|not, $object.main_node.is_hidden|not, $object.main_node.is_invisible|not )}
        {if and( is_set( $object.data_map.location ), $object.data_map.location.has_content )}
            <a href="{$object.data_map.location.content}"{if and( is_set( $object.data_map.open_in_new_window ), $object.data_map.open_in_new_window.data_int )} target="_blank"{/if}>{$object.name|wash}</a>
        {else}
            <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
        {/if}
	{else}
	    {$object.name|wash}
	{/if}
{/default}