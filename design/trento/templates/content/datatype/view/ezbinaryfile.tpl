{def $icon_size='normal'
     $icon_title=$attribute.content.mime_type
     $icon='no'}
{if is_set( $show_flip )|not()}
{def $show_flip = false()}
{/if}

<div class="content-view-embed">	 
<div class="class-file-embed">
<div class="content-body attribute-{$icon_title|slugize()}">

{if $attribute.has_content}
	{if $attribute.content}
	{switch match=$icon}
		{case match='no'}
			<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
                {$attribute.content.original_filename|wash( xhtml )} ({$attribute.content.filesize|si( byte )})
            </a>
		{/case}
		{case}
			<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
                {$attribute.content.mime_type|mimetype_icon( $icon_size, $icon_title )}
                {$attribute.content.original_filename|wash( xhtml )} ({$attribute.content.filesize|si( byte )})
            </a>
		{/case}
	{/switch}
	{else}
		<div class="message-error"><h2>{'The file could not be found.'|i18n( 'design/ezwebin/view/ezbinaryfile' )}</h2></div>
	{/if}
{/if}

    {if $show_flip}
        {include uri=flip_template( $attribute.id, $attribute.version ) id=$attribute.id version=$attribute.version view='small'}
    {/if}


</div>
</div>
</div>
