{if $openpa.content_main.has_content}
<div class="media">
    {if is_set( $openpa.content_main.parts.image )}
        {include uri='design:atoms/image.tpl' item=$node image_class=large css_classes="main_image" image_css_class="media-object tr_all_long_hover"}
    {/if}
    <div class="abstract">
        {if is_set( $openpa.content_main.parts.abstract )}
            {attribute_view_gui attribute=$openpa.content_main.parts.abstract.contentobject_attribute}
        {/if}
    </div>
    {if is_set( $openpa.content_main.parts.full_text )}
        {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
    {/if}

    {if $node.data_map.file.has_content}
        {* Download del bando come file *}
        {def $_SINGLE_FILE = $node.data_map.file}

        <div id="bando_file_downlaod">
            <a href={concat("content/download/",
                                $_SINGLE_FILE.contentobject_id,"/",
                                $_SINGLE_FILE.id,"/file/",
                                $_SINGLE_FILE.content.original_filename)|ezurl(,'full')} title="apri/scarica il file">
                        {$_SINGLE_FILE.content.original_filename|wash()}
            </a>&nbsp;<span class="size">({$_SINGLE_FILE.content.mime_type_part} - {$_SINGLE_FILE.content.filesize|si( 'byte', 'kilo' )} )</span>
        </div>

    {/if}

</div>
{/if}