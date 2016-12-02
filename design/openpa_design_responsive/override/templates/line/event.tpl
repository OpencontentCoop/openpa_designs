{*?template charset=utf-8?*}
{*
	TEMPLATE VIDE LINE
	mode		modalita' in cui visualizzare i link
	show_image 	modalita' di visualizzazione delle icone rappresentative della classe se non è valorizzata un'immagine
*}
{def $classi_con_data_inline = openpaini( 'GestioneClassi', 'classi_con_data_inline' )
	 $classi_senza_immagine_inline = openpaini( 'GestioneClassi', 'classi_senza_immagine_inline' )
	 $attributes_with_title= openpaini( 'GestioneAttributi', 'attributes_with_title' )
	 $attributes_to_show= openpaini( 'GestioneAttributi', 'attributes_to_show' )
}

{if is_set($mode)}
	{def $mode_link=$mode}
{else}
	{def $mode_link=''}
{/if}

{if is_set($show_image)}
	{def $show_icon_image=$show_image}
{else}
	{def $show_icon_image=''}
{/if}

{if is_set( $title_tag )|not()}{def $title_tag = 'header'}{/if}


<div class="class-{$node.class_identifier} line clearfix">

    {if $title_tag|eq('header')}<h3>
    {elseif $title_tag|eq('paragraph')}<strong><p>{/if}
        {include name=buttons node=$node uri='design:parts/openpa/edit_buttons.tpl' css_class="pull-right"} 
	{if and( is_set( $node.data_map.location ), $node.data_map.location.has_content )}
        <a href={$node.data_map.location.content|ezurl()} target="_blank" title="Apri il link '{$node.name|wash()}' in una pagina esterna (si lascerà il sito)">{$node.name|wash()}</a>
	{elseif is_set( $node.url_alias )}
        <a href={if $node.class_identifier|eq('area_tematica')}{$node.object.main_node.url_alias|ezurl}{else}{$node.url_alias|ezurl('no')}{/if} title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
    {else}
        {$node.name|wash()}
    {/if}
    {if $title_tag|eq('header')}</h3>
    {elseif $title_tag|eq('paragraph')}</strong></p>{/if}

	{if and( $show_icon_image|ne('nessuna'), $classi_con_immagine_inline|contains($node.class_identifier), $node.data_map.image.has_content )}
        <div class="main-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}
        

    
    {if $classi_con_data_inline|contains($node.class_identifier)}
    <div class="published">
        di {$node.object.published|l10n(date)}
        {if eq($node.class_identifier,'mozione') }
            {if and($node.data_map.data_consiglio.has_content, 
                $node.data_map.data_consiglio.content.timestamp|gt(0) )}
                - <strong>in consiglio:  </strong>
                {attribute_view_gui attribute=$node.data_map.data_consiglio}
            {/if}
            {if $node.data_map.note.has_content}
                - <strong>{attribute_view_gui attribute=$node.data_map.note}</strong>
            {/if}
        {/if}
    </div>
    {/if}

			
    {if is_set($node|has_abstract)}
        {$node|abstract()}
    {/if}
        

    {* ALTRI ATTRIBUTI *}
    {foreach $node.data_map as $attribute}
    {if $attribute.has_content}
        {if and( $attributes_with_title|contains( $attribute.contentclass_attribute_identifier ),
                 $classi_senza_correlazioni_inline|contains( $node.class_identifier )|not() )}            
            <p><strong>{$attribute.contentclass_attribute_name}: </strong>
            {attribute_view_gui href=nolink attribute=$attribute}</p>
        {/if}
        {if $attributes_to_show|contains($attribute.contentclass_attribute_identifier)}
            <p>{attribute_view_gui href=nolink attribute=$attribute}</p>
        {/if}
    {/if}
    {/foreach}

 </div>
