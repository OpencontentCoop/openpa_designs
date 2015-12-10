{def $valore = ''}
<tr class="{$sequence}">

<td>
    {if $node.class_identifier|ne('telefono')}
	
    <h4>
        <a href={$node.url_alias|ezurl()}>{$node.name|wash}</a>
        <small>{$node.class_name}</small>
    </h4>
    
    <a href={$node.url_alias|ezurl()}><small>{$node.path_with_names}</small></a>
    
	{else}
		{* FILTRO oggetti in $nodo_ricerca (Dip comune=54603) di classe "telefono"-attrib "Persona cui si riferisce"-utente,attr_ID=1508 *}
		{def $res_fetch = fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', concat( $node.object.class_identifier,'/','utente') ) ) }

		{if $res_fetch|count()|gt(0)}
	 		{foreach $res_fetch as $valore}
		 		<p><strong>{$node.name|wash()}</strong></p>
				<div class="blocco-attributi-utente">
					{$valore.main_node.name}	
				</div>
				<strong> Telefono </strong> {attribute_view_gui href=nolink attribute=$node.data_map.tipo_telefono}
	  		{/foreach}
		{/if}

	{/if}

	{if eq($node.class_identifier,'user') }

            {*OGGETTI INVERSAMENTE CORRELATI - RUOLI *}
            {include name=reverse_related_objects_specific_class_and_attribute_asText
                node=$node
                classe='ruolo'
                attrib='utente' 
                title="Ruolo"
                href="nolink"
                uri='design:parts/reverse_related_objects_specific_class_and_attribute_asText.tpl'}	

        {if openpaini( 'Nodi', 'Telefoni', false() )}
 		{* FILTRO oggetti in $nodo_ricerca (Telefoni=306324) di classe "telefono"-attributo "Persona cui si riferisce"-utente,attribute_ID=1508 *}
        {def $params=array( 1508, $node.object.id )
             $nodo_ricerca = openpaini( 'Nodi', 'Telefoni' )
             $telefoni_correlati=fetch('content', 'list',
                                                 hash('parent_node_id', $nodo_ricerca,
                                                      'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 'params', $params)
                                                      ) )}
        

            {if $telefoni_correlati|count()}
                <p><strong>Telefono: </strong> 
                {foreach $telefoni_correlati as $nodo_correlato}
                	{$nodo_correlato.name}, 
                {/foreach}</p>
            {/if}

            {if $node.data_map.email.has_content}
            	<p><strong> e-mail: </strong> {attribute_view_gui attribute=$node.data_map.email}</p>
            {/if}
        {/if}

	{else}
	
        {if eq($node.class_identifier,'mozione') }
            <p>
                {if is_set($node.data_map.data_consiglio)}
                    {if and($node.data_map.data_consiglio.has_content, $node.data_map.data_consiglio.content.timestamp|gt(0) )}
                        <strong>In consiglio:</strong>
                        {attribute_view_gui attribute=$node.data_map.data_consiglio}
                    {/if}
                {/if}
        
                {if is_set($node.data_map.note)}
                    {if $node.data_map.note.has_content}
                        - <strong> Esito: </strong>
                        {attribute_view_gui attribute=$node.data_map.note}
                    {/if}
                {/if}
            </p>
        {/if}
                
        {if $node|has_abstract()}
        <p>
            {$node|abstract()|openpa_shorten( 200 )}
        </p>
        {/if}


		{if is_set($node.data_map.oggetto)}
            {if $node.data_map.oggetto.has_content}
                <p>
                    {attribute_view_gui attribute=$node.data_map.oggetto}
                </p>
            {/if}
		{/if}
	
    {/if}

		
    {if is_set($node.data_map.telefono)}
        {if $node.data_map.telefono.has_content}
            <p>
                <strong>Telefono: </strong>
                {attribute_view_gui attribute=$node.data_map.telefono}
            </p>
        {/if}
    {elseif is_set($node.data_map.telefoni)}  
        {if $node.data_map.telefoni.has_content}
            <p>
                <strong>Telefono: </strong>
                {attribute_view_gui attribute=$node.data_map.telefoni}
            </p>
        {/if}
    {/if}
    
    {if is_set($node.data_map.incarico)}
        {if $node.data_map.incarico.has_content}
            <p>
                <strong>Incarico: </strong></strong>
                {attribute_view_gui href=nolink attribute=$node.data_map.incarico}
            </p>
        {/if}
    {/if}

    {if and( is_set($node.data_map.servizio), $node.data_map.servizio.has_content )}
        <p>
            <strong>Servizio: </strong>
            {attribute_view_gui href=nolink attribute=$node.data_map.servizio}
        </p>
    {/if}
    
    {if is_set($node.data_map.ufficio)}
        {if $node.data_map.ufficio.has_content}
            <p>
                <strong>Ufficio: </strong>
                {attribute_view_gui href=nolink attribute=$node.data_map.ufficio}
            </p>
        {/if}
    {/if}
    
    {if is_set($node.data_map.organo_competente)}
        {if $node.data_map.organo_competente.has_content}
            <p>
                <strong>Competenza: </strong>
                {attribute_view_gui href=nolink attribute=$node.data_map.organo_competente}
            </p>
        {/if}
    {/if}
    
    {if is_set($node.data_map.circoscrizione)}
        {if $node.data_map.circoscrizione.has_content}
            <p>
                <strong>Circoscrizione: </strong></strong>
                {attribute_view_gui href=nolink attribute=$node.data_map.circoscrizione}
            </p>
        {/if}
    {/if}
    
    {if is_set($node.data_map.struttura)}
        {if $node.data_map.struttura.has_content}
            <p>
                <strong>Struttura: </strong>
                {attribute_view_gui href=nolink attribute=$node.data_map.struttura}
            </p>
        {/if}
    {/if}
    
    {if is_set($node.data_map.lista_elettorale)}
        {if $node.data_map.lista_elettorale.has_content}
            <p>
                <strong>Lista: </strong>
                {attribute_view_gui href=nolink attribute=$node.data_map.lista_elettorale}
            </p>
        {/if}
    {/if}
    
    {if and( is_set($node.data_map.argomento), $node.data_map.argomento.has_content )}
        <p>
            <strong>Argomento: </strong>
            {attribute_view_gui href=nolink attribute=$node.data_map.argomento}
        </p>
    {/if}
    
    {if is_set($node.data_map.file)}
        {if and($node.data_map.file.has_content, $node.class_identifier|eq('file_pdf'))}
            {attribute_view_gui attribute=$node.data_map.file icon_size='medium' icon_title=$node.name icon='yes'}
        {/if}
    {/if}	  	

</td>


<td>
    {$node.object.published|l10n(date)}
</td>

</tr>
