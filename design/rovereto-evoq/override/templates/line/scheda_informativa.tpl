{def $classi_con_data_inline = openpaini( 'GestioneClassi', 'classi_con_data_inline' )	 
	 $classi_senza_correlazioni_inline = openpaini( 'GestioneClassi', 'classi_senza_correlazioni_inline' )
     $classi_senza_immagine_inline = openpaini( 'GestioneClassi', 'classi_senza_immagine_inline' )
     $classi_con_immagine_inline = openpaini( 'GestioneClassi', 'classi_con_immagine_inline' )
	 $attributes_with_title = openpaini( 'GestioneAttributi', 'attributes_with_title' )
	 $attributes_to_show = openpaini( 'GestioneAttributi', 'attributes_to_show' )
}

{if is_set($show_image)}
	{def $show_icon_image=$show_image}
{else}
	{def $show_icon_image='no'}
{/if}


<div class="class-{$node.class_identifier} line clearfix">

	<h3>
    {include name=buttons node=$node uri='design:parts/openpa/edit_buttons.tpl' css_class="pull-right"} 
	{if and( is_set( $node.data_map.location ), $node.data_map.location.has_content )}
        <a href={$node.data_map.location.content|ezurl()} target="_blank" title="Apri il link '{$node.name|wash()}' in una pagina esterna (si lascerà il sito)">{$node.name|wash()}</a>
	{elseif is_set( $node.url_alias )}
        <a href={if $node.class_identifier|eq('area_tematica')}{$node.object.main_node.url_alias|ezurl}{else}{$node.url_alias|ezurl('no')}{/if} title="{$node.name|wash()}">{$node.name|wash()}</a>
    {else}
        {$node.name|wash()}
    {/if}
    </h3>

	{if and( $show_icon_image|ne('nessuna'), $classi_con_immagine_inline|contains($node.class_identifier), $node.data_map.image.has_content )}
        <div class="main-image">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
	{/if}
        
	{* DATA *}
	{if $classi_con_data_inline|contains($node.class_identifier)}
		<p class="details">
			di {$node.object.published|l10n(date)}
			{if eq($node.class_identifier,'mozione') }
				{if and($node.data_map.data_consiglio.has_content, $node.data_map.data_consiglio.content.timestamp|gt(0) )}
			 		- <strong>in consiglio:  </strong> {attribute_view_gui attribute=$node.data_map.data_consiglio}
				{/if}
				{if $node.data_map.note.has_content}
					- <strong>{attribute_view_gui attribute=$node.data_map.note}</strong>
				{/if}
			{/if}
		</p>
	{/if}

    {* RUOLO *}
    {if array( 'user', 'dipendente', 'politico' )|contains( $node.class_identifier )}			
        {include name   = reverse_related_objects_specific_class_and_attribute_asText
                 node   = $node
                 classe = 'ruolo'
                 attrib = 'utente' 
                 title  = "Ruolo"
                 href   = "nolink"
                 uri    = 'design:parts/reverse_related_objects_specific_class_and_attribute_asText.tpl'}	
    {/if}

    {* TESTO ABSTRACT *}
			
    {if and( is_set($node.data_map.abstract), $node.data_map.abstract.has_content )}
        {attribute_view_gui attribute=$node.data_map.abstract}
        
    {elseif and(is_set($node.data_map.oggetto),$node.data_map.oggetto.has_content)}
        {attribute_view_gui attribute=$node.data_map.oggetto}
        
    {elseif and(is_set($node.data_map.incarico_affidato),$node.data_map.incarico_affidato.has_content)}
        <p>{attribute_view_gui attribute=$node.data_map.incarico_affidato}</p>
        
    {elseif is_set($node.data_map.testata)}
        {if $node.data_map.testata.has_content}
            <p>Tratto da <strong> {attribute_view_gui href=nolink attribute=$node.data_map.testata} </strong>
                {if $node.data_map.pagina.content|ne(0)}
                    a pagina {attribute_view_gui attribute=$node.data_map.pagina}
                    {if $node.data_map.pagina_continuazione.content|ne(0)}
                        e {attribute_view_gui attribute=$node.data_map.pagina_continuazione}
                    {/if}
                {/if}
                {if $node.data_map.autore.has_content}
                    di {attribute_view_gui attribute=$node.data_map.autore}
                {/if}
            </p>
        {/if}
        {if $node.data_map.argomento_articolo.has_content}
            <p>Su: <strong> {attribute_view_gui href=nolink attribute=$node.data_map.argomento_articolo} </strong></p>
        {/if}

    {elseif $node.class_identifier|eq('telefono')}
        {def $res_fetch=fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', 'telefono/utente' ) ) }
        {if $res_fetch|count()|gt(0)}
        <ul>
            {foreach $res_fetch as $valore}
            <li>{$valore.main_node.name} 
                {if $node.data_map.numero_interno.has_content} 
                    ( interno: {attribute_view_gui attribute=$node.data_map.numero_interno})
                {/if}
            </li>
            {/foreach}
        </ul>
        {/if}				

    {elseif $node.class_identifier|eq('applicativo')}
        {attribute_view_gui attribute=$node.data_map.location_applicativo}
    
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