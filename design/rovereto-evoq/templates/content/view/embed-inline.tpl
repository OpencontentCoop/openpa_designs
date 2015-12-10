{default attribute_parameters=array()}
{if and( $object.main_node_id|null|not, $object.main_node.is_hidden|not, $object.main_node.is_invisible|not )}
    <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
{else}
    {$object.name|wash}
{/if}
{/default}
