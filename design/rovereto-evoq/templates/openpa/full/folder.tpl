{if $node.data_map.view.value[0]|ne('')}
    {def $type_c = $node.data_map.view.class_content.options[$node.data_map.view.value[0]].name|downcase()}
	{include uri=concat("design:full/folder_view_", $type_c, ".tpl") }
{else}
	{include uri=concat("design:full/folder_view_default.tpl") }
{/if}
