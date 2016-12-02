{* File - List embed view *}

{if $object.main_node.data_map.file.content.contentobject_attribute_id}
	{def $file = $object.main_node.data_map.file}

	<div class="embed {$object.class_identifier}">
		<a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>
			<span class="glyphicon glyphicon-paperclip"></span> {$object.main_node.name}
		</a> 
		{$file.content.filesize|si(byte)}
	</div>

	{undef $file}

{/if}

