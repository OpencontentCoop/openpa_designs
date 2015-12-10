{*?template charset=utf-8?*}
{*
	TEMPLATE VIDE LINE
	mode	modalita' in cui visualizzare i link
*}
{def $classi_con_immagine_inline = openpaini( 'GestioneClassi', 'classi_con_immagine_inline' )
	 $attributes_to_show= openpaini( 'GestioneAttributi', 'attributes_to_show_politici', array())
	 $attributes_structure=array('lista_elettorale','gruppo_politico')
	 $attributes_with_title=openpaini( 'GestioneAttributi', 'attributes_with_title_politici', array())
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
<div class="line class-politico clearfix">
 	{if $title_tag|eq('header')}<h3>
    {elseif $title_tag|eq('paragraph')}<strong><p>{/if}
    {if is_set( $node.url_alias )}
        <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
    {else}
        {$node.name|wash()}
    {/if}
    
    {if $title_tag|eq('header')}</h3>
    {elseif $title_tag|eq('paragraph')}</strong></p>{/if}
    
    {if and( $show_icon_image|ne('nessuna'), $classi_con_immagine_inline|contains($node.class_identifier), $node.data_map.image.has_content )}
        <div class="main-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}

    <p class="details">
        {foreach $node.data_map as $attribute}
            {if $attributes_structure|contains($attribute.contentclass_attribute_identifier)}
                {if $attribute.has_content}
                    {if eq($attribute.data_type_string,'ezdate')}					                            
                        {if $attribute.content.is_valid}
                            <strong>{$attribute.contentclass_attribute_name}: </strong>
                            {attribute_view_gui attribute=$attribute}
                        {/if}
                    {else}
                        <strong>{$attribute.contentclass_attribute_name}: </strong>
                        {attribute_view_gui attribute=$attribute}
                    {/if}
                {/if}
            {/if}
        {/foreach}
    </p>
    
    {if $node|has_abstract}
        <p>{$node|abstract}</p>
    {/if}

    {* mostro gli altri attributi *}
    {if count($attributes_to_show)|gt(0)}
    {foreach $node.data_map as $attribute}		
        {if $attributes_with_title|contains($attribute.contentclass_attribute_identifier)}
            {if $attribute.has_content}
                </p><strong>{$attribute.contentclass_attribute_name}: </strong>
                {attribute_view_gui attribute=$attribute}</p>
            {/if}
        {/if}
        {if $attributes_to_show|contains($attribute.contentclass_attribute_identifier)}
            {if $attribute.has_content}
                <p>{attribute_view_gui attribute=$attribute}</p>
            {/if}
        {/if}	
    {/foreach}
    {/if}
</div>
