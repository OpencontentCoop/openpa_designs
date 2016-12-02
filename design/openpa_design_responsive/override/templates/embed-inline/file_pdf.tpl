{if $object.data_map.file.has_content}
    {def $file = $object.data_map.file}
    <a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>
        <span class="glyphicon glyphicon-paperclip"></span> {$object.name|wash}
    </a>
    {undef $file}
{else}
    <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
{/if}