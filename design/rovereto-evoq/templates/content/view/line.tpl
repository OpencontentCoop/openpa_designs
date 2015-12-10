{default node_name=$object.main_node.name node_url=$object.main_node.url_alias}
{if and( $object.main_node.is_hidden|not, $object.main_node.is_invisible|not )}<a href={$node_url|ezurl}>{$node_name|wash}</a>{else}{$node_name|wash}{/if}
{/default}