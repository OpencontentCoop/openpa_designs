{*?template charset=utf-8?*}
{*
	TEMPLATE VIDE LINE
	mode		modalita' in cui visualizzare i link
	show_image 	modalita' di visualizzazione delle icone rappresentative della classe se non è valorizzata un'immagine
*}
{def $classes_parent_to_edit=array('file_pdf', 'news')
	 $current_user = fetch( 'user', 'current_user' )
	 $has_servizio='none'
     $servizio = array()
	 $classi_senza_data_inline = ezini( 'GestioneClassi', 'classi_senza_data_inline', 'openpa.ini')
	 $classi_senza_correlazioni_inline = ezini( 'GestioneClassi', 'classi_senza_correlazioni_inline', 'openpa.ini')
	 $classi_con_immagine_inline = ezini( 'GestioneClassi', 'classi_con_immagine_inline', 'openpa.ini')
	 $classi_senza_immagine_inline = ezini( 'GestioneClassi', 'classi_senza_immagine_inline', 'openpa.ini')	 
	 $attributes_with_title= ezini( 'GestioneAttributi', 'attributes_with_title', 'openpa.ini')
	 $attributes_to_show= ezini( 'GestioneAttributi', 'attributes_to_show', 'openpa.ini')
	 $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiLine', 'openpa.ini')
     $servizio_utente = fetch( 'content', 'related_objects', hash( 'object_id', $current_user.contentobject_id, 'attribute_identifier', 909,'all_relations', false() ))
}
{if is_set($mode)}
	{def $mode_link=$mode}
{else}
	{def $mode_link=''}
{/if}

{if is_set($original_link)|not()}
    {set $mode_link=''}
{/if}

{if is_set($show_image)}
	{def $show_icon_image=$show_image}
{else}
	{def $show_icon_image=''}
{/if}


{if $classes_parent_to_edit|contains($node.class_identifier)}
	{if is_set($node.data_map.servizio)}
        {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.parent.object.id, 'attribute_identifier', concat($node.parent.class_identifier, '/servizio'),'all_relations', false() )) }
    {/if}
    {if $servizio|gt(0)}
        {set $has_servizio='ok'}
    {/if}
{else}
	{if is_set($node.data_map.servizio)}
        {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.object.id,'attribute_identifier', concat($node.class_identifier, '/servizio'),'all_relations', false() )) }
	{/if}
    {if $servizio|gt(0)}
        {set $has_servizio='ok'}
    {/if}
{/if}

{def $cronjob=false()}
{if is_set($node.data_map.enqueue)}
    {if $node.data_map.enqueue.content|eq(1)}
        {def $cronjob=true()}
    {/if}
{/if}

<div id="line-{$node.node_id}" class="content-view-line class-documento float-break line-handler {include uri='design:parts/openpa/line_style.tpl'} {$node.class_identifier}" {if $cronjob}style="background: #FF0066; padding: 5px;"{/if}>
	
    {if $cronjob}<strong>In coda nel prossimo cronjob</strong>{/if}

	{if $classi_senza_immagine_inline|contains($node.class_identifier)|not()}
		{if is_set($node.data_map.image)}
			{if $show_icon_image|ne('nessuna')}
				{if $node.data_map.image.has_content}
					<div class="main-image left">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
				{elseif $show_icon_image|ne('no')}
					{include node=$node uri='design:parts/common/class_icon.tpl' css_class="image-small"}
				{/if}
			{/if}
		{/if}
	{/if}

	<div class="blocco-titolo-oggetto">    
 		<div class="titolo-blocco-titolo">
			{if $node.class_identifier|eq('link')}
                <h3><a href={$node.data_map.location.content|ezurl()} target="_blank" title="Apri il link '{$node.name|wash()}' in una pagina esterna (si lascerà il sito)">{$node.name|wash()}</a></h3>
			{else}
				{if is_set( $node.url_alias )}
                    <h3><a href={if $node.class_identifier|eq('area_tematica')}{$node.object.main_node.url_alias|ezurl}{else}{$node.url_alias|ezurl('no')}{/if} title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
				{else}
                    <h3>{$node.name|wash()}</h3>
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
    </div>
    
    <div class="blocco-contenuto-oggetto"> 
		{if $classi_senza_data_inline|contains($node.class_identifier)|not}
		<div class="published">
			di {$node.object.published|l10n(date)}
			{if eq($node.class_identifier,'mozione') }
				{if and($node.data_map.data_consiglio.has_content, $node.data_map.data_consiglio.content.timestamp|gt(0) )}
			 		- <strong>in consiglio:  </strong>{attribute_view_gui attribute=$node.data_map.data_consiglio}
				{/if}
				{if $node.data_map.note.has_content}
					- <strong>{attribute_view_gui attribute=$node.data_map.note}</strong>
				{/if}
			{/if}
		</div>
		{/if}


        {if $node.class_identifier|eq('user')}
			{*OGGETTI INVERSAMENTE CORRELATI - RUOLI *}
	 		{include name=reverse_related_objects_specific_class_and_attribute_asText
				node=$node
				classe='ruolo'
				attrib='utente' 
				title="Ruolo"
				href="nolink"
				uri='design:parts/reverse_related_objects_specific_class_and_attribute_asText.tpl'}	
        {/if}

        {if is_set($node.data_map.abstract)}
            {if and( $node.data_map.abstract.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/abstract') )|not() )}
                <div class="abstract-line">
                    {attribute_view_gui attribute=$node.data_map.abstract}
                </div>
            {/if}

        {elseif and(is_set($node.data_map.oggetto),$node.data_map.oggetto.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/oggetto') )|not() )}
            {attribute_view_gui attribute=$node.data_map.oggetto}

        {elseif and(is_set($node.data_map.incarico_affidato),$node.data_map.incarico_affidato.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/incarico_affidato') )|not() )}
            <div class="abstract-line">
                {attribute_view_gui attribute=$node.data_map.incarico_affidato}
            </div>

        {elseif and( is_set($node.data_map.testata), $attributi_essenziali|contains( concat($node.class_identifier, '/testata') )|not() )}
            <div class="abstract-line">
                {if $node.data_map.testata.has_content}
                    <p>Tratto da 
                    <strong> {attribute_view_gui href=nolink attribute=$node.data_map.testata} </strong>
                    {if $node.data_map.pagina.content|ne(0)}
                        a pagina {attribute_view_gui attribute=$node.data_map.pagina}
                        {if $node.data_map.pagina_continuazione.content|ne(0)} e {attribute_view_gui attribute=$node.data_map.pagina_continuazione}{/if}
                    {/if}
                
                    {if $node.data_map.autore.has_content}
                        di {attribute_view_gui attribute=$node.data_map.autore}
                    {/if}
                    </p>
                {/if}
                
                {if $node.data_map.argomento_articolo.has_content}
                    <p>Su: <strong> {attribute_view_gui href=nolink attribute=$node.data_map.argomento_articolo}</strong></p>
                {/if}
            </div>
            
		{elseif $node.class_identifier|eq('telefono')}
			
            {* FILTRO oggetti in $nodo_ricerca (Dip comune=54603) di classe "telefono"-attrib "Persona cui si riferisce"-utente,attr_ID=1508 *}
			{def $res_fetch=fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', concat( $node.object.class_identifier,'/','utente') ) ) }
			{if $res_fetch|count()|gt(0)}
				<div class="abstract-line">
 				{foreach $res_fetch as $valore}
                    {$valore.main_node.name} 
                    {if $node.data_map.numero_interno.has_content} 
                        ( interno: {attribute_view_gui attribute=$node.data_map.numero_interno})
                    {/if}
                {/foreach}
                </div>
            {/if}

        {elseif $node.class_identifier|eq('csv_oscura_oggetti')}
            {attribute_view_gui attribute=$node.data_map.tipo_atto}				

        {/if}

        {if $node.class_identifier|eq('applicativo')}
            {attribute_view_gui attribute=$node.data_map.location_applicativo}
        {/if}


		{foreach $node.data_map as $attribute}
        {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier ) )|not()}
			{if $attributes_with_title|contains($attribute.contentclass_attribute_identifier)}
				{if $attribute.has_content}
    				{if $classi_senza_correlazioni_inline|contains($node.class_identifier)|not}
    					{if $attribute.contentclass_attribute_identifier|ne('servizio')}
    						<strong>{$attribute.contentclass_attribute_name}: </strong> {attribute_view_gui href=nolink attribute=$attribute}<br/>
                        {else}					
                            <strong>{$attribute.contentclass_attribute_name}: </strong> {attribute_view_gui href=nolink attribute=$attribute}
                        {/if}
                    {/if}
				{/if}
			{/if}
			{if $attributes_to_show|contains($attribute.contentclass_attribute_identifier)}
				{if $attribute.has_content}
					{attribute_view_gui href=nolink attribute=$attribute}
				{/if}
			{/if}
        {/if}
		{/foreach}

	</div>
</div>