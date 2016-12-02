{if $object.main_node.data_map.file.content.contentobject_attribute_id}
	{def $file = $object.main_node.data_map.file}
		<a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>
			{$object.main_node.name}
		</a>
		{$file.content.filesize|si(byte)}
  {undef $file}
{/if}
