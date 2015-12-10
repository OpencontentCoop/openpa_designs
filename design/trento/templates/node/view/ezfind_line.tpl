{def $valore = ''
     $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiSearchLine', 'openpa.ini')}
<tr class="{$sequence}">
{if $show_class}
<td style="text-align:center;width:5%;"> 
	{if $node.class_identifier|eq('articolo')}
		<div class="immagine-blocco-titolo">
			{attribute_view_gui attribute=$node.data_map.image image_class='small'}
		</div>
	{else}
        {if is_set( $node.class_identifier )}
            <div class="immagine-blocco-titolo">
                <img class="image-ezfind" src={concat('icons/crystal/64x64/mimetypes/',$node.class_identifier,'.png')|ezimage()} alt="{$node.object.class_identifier}" title="{$node.object.class_identifier}" />
            </div>
        {/if}
	{/if}
</td>
{/if}
<td>
<div id="line-{$node.node_id}" class="line-handler {include uri='design:parts/openpa/line_style.tpl'}">
    
	<div class="blocco-titolo-oggetto">   
        {if $node.class_identifier|ne('telefono')}
            <h3>
                {if $node.class_identifier|ne('file_pdf')}
                    <a href={$node.url_alias|ezurl()}>{$node.name|wash}</a>
                {else}
                    <a href={$node.url_alias|ezurl()}>{$node.name|wash}</a>
                {/if}		
            </h3>
        {else}
            {* FILTRO oggetti in $nodo_ricerca (Dip comune=54603) di classe "telefono"-attrib "Persona cui si riferisce"-utente,attr_ID=1508 *}
            {def $res_fetch= fetch( 'content', 'related_objects',hash( 'object_id', $node.object.id,'attribute_identifier', concat( $node.object.class_identifier,'/','utente') ) ) }
            {if $res_fetch|count()|gt(0)}
                {foreach $res_fetch as $valore}
                    <h3>{$node.name|wash()}{*<a href="{$valore.main_node.url_alias|ezurl()}"></a>*}</h3> 
                    <div class="blocco-attributi-utente">
                        {$valore.main_node.name}	
                    </div>
                    <span class="label"> Telefono </span> {attribute_view_gui href=nolink attribute=$node.data_map.tipo_telefono}
                {/foreach}
            {/if}
        {/if}
        {foreach $node.object.contentobject_attributes as $attribute}
            {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier) )}
                {if $attribute.has_content}
                    {attribute_view_gui href=nolink attribute=$attribute}
                {/if}			
            {/if}			
        {/foreach}
    </div>
    
    <div class="blocco-contenuto-oggetto"> 
        {if eq($node.class_identifier,'user') }
            <div class="servizio-blocco-attributi">
                {*OGGETTI INVERSAMENTE CORRELATI - RUOLI *}
                {include name=reverse_related_objects_specific_class_and_attribute_asText
                         node=$node
                         classe='ruolo'
                         attrib='utente' 
                         title="Ruolo"
                         href="nolink"
                         uri='design:parts/reverse_related_objects_specific_class_and_attribute_asText.tpl'}	
            </div>
            
            {* FILTRO oggetti in $nodo_ricerca (Telefoni=306324) di classe "telefono"-attributo "Persona cui si riferisce"-utente,attribute_ID=1508 *}
            {def $params=array(1508,$node.object.id)
                 $nodo_ricerca=306324
                 $telefoni_correlati=fetch('content', 'list',hash('parent_node_id', $nodo_ricerca,'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 'params', $params)) )}
    
            <div class="blocco-attributi-utente">	  
                {if $telefoni_correlati|count()}
                    <span class="label">Telefono: </span> 
                    {foreach $telefoni_correlati as $nodo_correlato}
                        {$nodo_correlato.name}
                        {delimiter}, {/delimiter}
                    {/foreach}
                {/if}
                
                {if $node.data_map.email.has_content}
                    <span class="label"> e-mail: </span> {attribute_view_gui attribute=$node.data_map.email}
                {/if}
            </div>
    
    
        {elseif $node.class_identifier|eq('politico')}
            {def $ruolo=false()}
            {if $node.data_map.ruolo.has_content}
                {set $ruolo = $node.data_map.ruolo}
            {/if}            
            {if and( $ruolo, $attributi_essenziali|contains( concat($node.class_identifier, '/ruolo') )|not() )}
                {attribute_view_gui attribute=$node.data_map.ruolo}
            {else}
                {if $node.data_map.ruolo2.has_content}
                    {attribute_view_gui attribute=$node.data_map.ruolo2}
                {elseif $node.data_map.abstract.has_content}			
                    {attribute_view_gui attribute=$node.data_map.abstract}
                {/if}
            {/if}
                        
    
        {else}	
            {if eq($node.class_identifier,'mozione') }
                <div class="attribute-mozione">
                {if is_set($node.data_map.data_consiglio)}
                    {if and($node.data_map.data_consiglio.has_content, $node.data_map.data_consiglio.content.timestamp|gt(0) )}
                        <strong>In consiglio:</strong> {attribute_view_gui attribute=$node.data_map.data_consiglio}
                    {/if}
                {/if}
                {if is_set($node.data_map.note)}
                    {if $node.data_map.note.has_content}
                    - <strong> Esito: </strong> {attribute_view_gui attribute=$node.data_map.note}
                    {/if}
                {/if}
                </div>
            {/if}
    
            {if is_set($node.data_map.abstract)}
                {if and( $node.data_map.abstract.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/abstract') )|not() )}
                    <div class="attribute-abstract">
                        {attribute_view_gui attribute=$node.data_map.abstract}
                    </div>
                {/if}
            {/if}
    
    
            {if is_set($node.data_map.oggetto)}
                {if and( $node.data_map.oggetto.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/oggetto') )|not() )}
                    <div class="attribute-oggetto">
                        {attribute_view_gui attribute=$node.data_map.oggetto}
                    </div>
                {/if}
            {/if}
    
            {if is_set($node.data_map.testata)}
                {if and( $node.data_map.testata.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/testata') )|not() )}
                    <p>Tratto da: 
                        <strong> {attribute_view_gui href=nolink attribute=$node.data_map.testata} </strong>
                        {if $node.data_map.pagina.content|ne(0)}
                            a pag. {attribute_view_gui attribute=$node.data_map.pagina}
                            {if $node.data_map.pagina_continuazione.content|ne(0)} e {attribute_view_gui attribute=$node.data_map.pagina_continuazione}{/if}
                        {/if}
                        {if $node.data_map.autore.has_content}
                            (di {attribute_view_gui attribute=$node.data_map.autore})
                        {/if}
                    </p>
                    {if $node.data_map.argomento_articolo.has_content}
                        <p>Su: <strong>{attribute_view_gui href=nolink attribute=$node.data_map.argomento_articolo}</strong></p>
                    {/if}
                {/if}
            {/if}
    
        {/if}
    
        <div class="blocco-attributi-oggetto">
                    
            {if is_set($node.data_map.telefono)}                
                {if and( $node.data_map.telefono.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/telefono') )|not() )}
                    <div class="servizio-blocco-attributi">
                        <strong><span class="label">Telefono: </span> </strong> {attribute_view_gui attribute=$node.data_map.telefono}
                    </div>
                {/if}
            {elseif is_set($node.data_map.telefoni)}  
                {if and( $node.data_map.telefoni.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/telefoni') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Telefono: </span> </strong>{attribute_view_gui attribute=$node.data_map.telefoni}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.servizio)}                
                {if and( $node.data_map.servizio.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/servizio') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Servizio: </span></strong>{attribute_view_gui href=nolink attribute=$node.data_map.servizio}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.incarico)}
                {if and( $node.data_map.incarico.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/incarico') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Incarico: </span></strong>{attribute_view_gui href=nolink attribute=$node.data_map.incarico}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.ufficio)}
                {if and( $node.data_map.ufficio.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/ufficio') )|not() )}
                <div class="servizio-blocco-attributi">
                   <strong><span class="label">Ufficio: </span> </strong>{attribute_view_gui href=nolink attribute=$node.data_map.ufficio}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.organo_competente)}
                {if and( $node.data_map.organo_competente.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/organo_competente') )|not() )}
                <div class="servizio-blocco-attributi">
                   <strong><span class="label">Competenza: </span> </strong>{attribute_view_gui href=nolink attribute=$node.data_map.organo_competente}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.circoscrizione)}                
                {if and( $node.data_map.circoscrizione.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/circoscrizione') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Circoscrizione: </span></strong>{attribute_view_gui href=nolink attribute=$node.data_map.circoscrizione}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.struttura)}                
                {if and( $node.data_map.struttura.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/struttura') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Struttura: </span> </strong>{attribute_view_gui href=nolink attribute=$node.data_map.struttura}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.altra_struttura)}
                {if and( $node.data_map.altra_struttura.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/altra_struttura') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Struttura interna: </span> </strong>{attribute_view_gui href=nolink attribute=$node.data_map.altra_struttura}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.lista_elettorale)}
                {if and( $node.data_map.lista_elettorale.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/lista_elettorale') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Lista: </span> </strong>{attribute_view_gui href=nolink attribute=$node.data_map.lista_elettorale}
                </div>
                {/if}
            {/if}
            
            {if and( is_set($node.data_map.argomento), $node.data_map.argomento.has_content )}
                {if and( $node.data_map.argomento.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/argomento') )|not() )}
                <div class="servizio-blocco-attributi">
                    <strong><span class="label">Argomento: </span> </strong>{attribute_view_gui href=nolink attribute=$node.data_map.argomento}
                </div>
                {/if}
            {/if}
            
            {if is_set($node.data_map.file)}
                {if and($node.data_map.file.has_content, $node.class_identifier|eq('file_pdf'), $attributi_essenziali|contains( concat($node.class_identifier, '/file') )|not() )}
                    {attribute_view_gui attribute=$node.data_map.file icon_size='medium' icon_title=$node.name icon='yes'}
                {/if}
            {/if}
    
        </div>
    </div>
</div>
</td>


<td>
    <div class="argomento-blocco-attributi">
        {$node.object.published|l10n(shortdate)}
    </div>
</td>

</tr>