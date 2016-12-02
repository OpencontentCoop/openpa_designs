{*?template charset=utf-8?*}
{*
	TEMPLATE VIDE LINE

	node	nodo di riferimento
	mode	modalita' in cui visualizzare i link
*}

{def 	
	$classi_senza_image = array('file_pdf')
	$classi_senza_data_inline = openpaini( 'GestioneClassi', 'classi_senza_data_inline')
	$classi_senza_correlazioni_inline = openpaini( 'GestioneClassi', 'classi_senza_correlazioni_inline')
 	$attributes_to_show=array('organo_competente', 'circoscrizione','struttura','altra_struttura')
	$attributes_with_title=array('servizio','incarico','ufficio','argomento')
}


{if is_set($mode)}
	{def $mode_link=$mode}
{else}
	{def $mode_link=''}
{/if}

<h4>
{if $node.class_identifier|eq('link')}
    <a href={$node.data_map.location.content|ezurl()} title="{$node.name|wash()}">{$node.name|wash()}</a>
{else}
    {if is_set( $node.url_alias )}
        {if $mode_link|eq('virtual')}
            <a href={concat("/",$original_link,"/(node)/",$node.node_id)} title="{$node.name|wash()}">
            {$node.name|wash()}
            </a>
        {else}
            <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
        {/if}
    {else}
        {$node.name|wash()}
    {/if}
{/if}


{* mostro (eventualmente) la data di pubblicazione (indotta) *}
		
{if $classi_senza_data_inline|contains($node.class_identifier)|not}
    <small>di {$node.object.published|l10n(date)}</small>
{/if}

</h4>


{* mostro gli attributi da mostrare *}

<div class="content clearfix">

    {if and( is_set($node.data_map.image), $node.data_map.image.has_content )}
		<div class="main-image">
        {attribute_view_gui attribute=$node.data_map.image href=$node.url_alias|ezurl() image_class=lista_accordion}
        </div>
    {/if}

    {if $node.class_identifier|eq('user')}
					    
        {include name=reverse_related_objects_specific_class_and_attribute_asText
                 node=$node
                 classe='ruolo'
                 attrib='utente' 						
                 title="Ruolo"
                 href="nolink"
                 uri='design:parts/reverse_related_objects_specific_class_and_attribute_asText.tpl'}
	
    {elseif $node.class_identifier|eq('politico')}
        
        {def $ruolo=false()}
        {if $node.data_map.ruolo.has_content}
            {set $ruolo = $node.data_map.ruolo}
        {/if}
        {if $ruolo}
            <p>{attribute_view_gui attribute=$node.data_map.ruolo}</p>
        {else}
            {if $node.data_map.ruolo2.has_content}
                <p>{attribute_view_gui attribute=$node.data_map.ruolo2}</p>
            {elseif $node.data_map.abstract.has_content}		
                {attribute_view_gui attribute=$node.data_map.abstract}
            {/if}
        {/if}
                
    {elseif and( is_set($node.data_map.abstract), $node.data_map.abstract.has_content )}
            {attribute_view_gui attribute=$node.data_map.abstract}

    {elseif and( is_set($node.data_map.oggetto), $node.data_map.oggetto.has_content )}
            {attribute_view_gui attribute=$node.data_map.oggetto}

    {elseif is_set($node.data_map.testata)}
       
        {if $node.data_map.testata.has_content}
            <p>Tratto da: 
                <strong> {attribute_view_gui  href=nolink attribute=$node.data_map.testata} </strong>
                {if $node.data_map.pagina.content|ne(0)}
                    a pag. {attribute_view_gui attribute=$node.data_map.pagina}
                    {if $node.data_map.pagina_continuazione.content|ne(0)} e {attribute_view_gui attribute=$node.data_map.pagina_continuazione}{/if}
                {/if}
                {if $node.data_map.autore.has_content}
                    (di {attribute_view_gui attribute=$node.data_map.autore})
                {/if}
            </p>
       {/if}    
       
        {if $node.data_map.argomento_articolo.has_content}
            <p>Su: <strong>{attribute_view_gui href=nolink attribute=$node.data_map.argomento_articolo}</strong></p>
        {/if}

    {elseif and( is_set($node.data_map.utente), $node.data_map.utente.has_content )}
            {attribute_view_gui attribute=$node.data_map.utente}

    {elseif and( is_set( $node.data_map.abstract ), $node.data_map.abstract.has_content )}
        {attribute_view_gui attribute=$node.data_map.abstract}

    {elseif $node|has_abstract()}	
        <p>{$node|abstract()|openpa_shorten(300)}</p>
    
    {/if}
    
    {if $node.class_identifier|eq('applicativo')}
        {attribute_view_gui attribute=$node.data_map.location_applicativo}
    {/if}
					
    {* mostro gli altri attributi *}
	{foreach $node.data_map as $attribute}
        {if and( $attributes_to_show|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
            <p>{attribute_view_gui href=nolink attribute=$attribute}</p>
			
		{elseif and( $attributes_with_title|contains($attribute.contentclass_attribute_identifier), $attribute.has_content, $classi_senza_correlazioni_inline|contains($node.class_identifier)|not )}
			<p><strong>{$attribute.contentclass_attribute_name}: </strong>
            {attribute_view_gui href=nolink attribute=$attribute}</p>
			
		{/if}
			
	{/foreach}

				
 </div>