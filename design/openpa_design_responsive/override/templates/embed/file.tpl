{* File - List embed view *}
<div class="embed {$object-class-identifier}">
    {if $object.data_map.file.has_content}
    {def $file = $object.data_map.file}
        <a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|ezurl}>
            <span class="glyphicon glyphicon-paperclip"></span>
            {$file.content.original_filename|wash("xhtml")}</a> {$file.content.filesize|si(byte)}
    {undef $file}
    {else}
        <a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a>
    {/if}
   </div>
</div>