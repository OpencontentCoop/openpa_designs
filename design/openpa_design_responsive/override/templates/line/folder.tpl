{* Folder - Line view *}

{def $classi_con_immagine_inline = openpaini( 'GestioneClassi', 'classi_con_immagine_inline' )
     $classi_senza_immagine_inline = openpaini( 'GestioneClassi', 'classi_senza_immagine_inline' )}

{if is_set($show_image)}
	{def $show_icon_image=$show_image}
{else}
	{def $show_icon_image=''}
{/if}

{if is_set( $title_tag )|not()}{def $title_tag = 'header'}{/if}
<div class="class-{$node.class_identifier} line clearfix">
    {if $title_tag|eq('header')}<h3>
    {elseif $title_tag|eq('paragraph')}<strong><p>{/if}
        <a href={$node.url_alias|ezurl} title="{$node.name|wash}">{$node.name|wash}</a>
    {if $title_tag|eq('header')}</h3>
    {elseif $title_tag|eq('paragraph')}</strong></p>{/if}
    {if and( $show_icon_image|ne('nessuna'), $classi_con_immagine_inline|contains($node.class_identifier), $node.data_map.image.has_content )}
        <div class="main-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}
    {if is_set($node|has_abstract)}
        {$node|abstract()}
    {/if}
</div>