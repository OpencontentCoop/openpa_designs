{def $classi_con_immagine_inline = openpaini( 'GestioneClassi', 'classi_con_immagine_inline' )
     $classi_senza_immagine_inline = openpaini( 'GestioneClassi', 'classi_senza_immagine_inline' )}

{if is_set($show_image)}
	{def $show_icon_image=$show_image}
{else}
	{def $show_icon_image=''}
{/if}

<div class="class-{$node.class_identifier} line clearfix">
    <h3><a href={$node.url_alias|ezurl} title="{$node.name|wash}">{$node.name|wash}</a></h3>
    {if and( $show_icon_image|ne('nessuna'), $classi_con_immagine_inline|contains($node.class_identifier), $node.data_map.image.has_content )}
        <div class="main-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}
    {if is_set($node|has_abstract)}
        {$node|abstract()}
    {/if}
    <p class="details">
        <span class="date">{$node.object.published|l10n(date)}</span>
        <span class="count">{"%count votes"|i18n( 'design/ezwebin/line/poll',, hash( '%count', fetch( content, collected_info_count, hash( object_id, $node.object.id ) ) ) )}</span>        
    </p>
    <p><a class="btn btn-primary" href={$node.url_alias|ezurl}>{"Vote"|i18n("design/ezwebin/line/poll")}</a></p>
</div>