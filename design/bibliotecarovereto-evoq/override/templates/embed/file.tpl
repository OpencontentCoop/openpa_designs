{* File - List embed view *}
{if $object.data_map.file.has_content}
    {def $file = $object.data_map.file}
    {*<i class="fa mime-file mime-{$file.content.mime_type_part|explode('.')|implode('-')}"></i>*}
    <a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>{$file.content.original_filename|wash("xhtml")}</a> {*$file.content.filesize|si(byte)*}
    {undef $file}
{else}
    <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
{/if}
