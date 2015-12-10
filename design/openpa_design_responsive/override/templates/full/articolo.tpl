{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $classes = openpaini( 'GestioneClassi', 'classi_figlie_da_escludere' )
	 $classes_figli = openpaini( 'GestioneClassi', 'classi_figlie_da_includere' )
	 $classes_figli_escludi = openpaini( 'GestioneClassi', 'classi_figlie_da_escludere' )
	 $classi_commentabili = openpaini( 'GestioneClassi', 'classi_commentabili' )
	 $classes_edizioni_figli = array( 'edizione', 'edizione_lunga')
	 $classes_parent_to_edit=array('file_pdf', 'news')
	 $classi_da_non_commentare=array('news', 'comment')
	 $oggetti_correlati = openpaini( 'DisplayBlocks', 'oggetti_correlati' )
	 $oggetti_correlati_centro = array( 'riferimento')
	 $attributi_classificazione_articolo = array( 'testata', 'argomento_articolo')		
	 $attributi_da_escludere = array( 'testata', 'argomento_articolo', 'pagina','pagina_continuazione')	
	 $attributi_da_evidenziare = openpaini( 'GestioneAttributi', 'attributi_da_evidenziare' )
	 $oggetti_senza_label = openpaini( 'GestioneAttributi', 'oggetti_senza_label' )	
	 $current_user = fetch( 'user', 'current_user' )
}

{ezscript_require( array( 'ezjsc::jquery', 'jexcerpt.js', 'excerpt.js' ) )}

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

        <h1>{$node.name|wash()}</h1>
        {* DATA e ULTIMAMODIFICA *}
        {include name = last_modified
                 node = $node             
                 uri = 'design:parts/openpa/last_modified.tpl'}
        
        {* EDITOR TOOLS *}
        {include name = editor_tools
                 node = $node             
                 uri = 'design:parts/openpa/editor_tools.tpl'}
    
        {* ATTRIBUTI : mostra i contenuti del nodo *}
        {include name = attributi_principali
                 uri = 'design:parts/openpa/attributi_principali.tpl'
                 node = $node}
            
        <div class="row attributi-principali">
            <div class="col-md-12">
        
            {if $node.data_map.autore.has_content}
                <p><strong>Scritto da: </strong>{attribute_view_gui attribute=$node.data_map.autore}
            {/if}
            {if $node.data_map.testata.has_content}
                <p><strong>Sul giornale: </strong>{attribute_view_gui href=nolink attribute=$node.data_map.testata}</p>
            {/if}
            {if $node.data_map.pagina.content|ne(0)}
                <p><strong>A pagina: </strong>{attribute_view_gui attribute=$node.data_map.pagina}
                {if $node.data_map.pagina_continuazione.content|ne(0)} e {attribute_view_gui attribute=$node.data_map.pagina_continuazione}
                {/if}
                </p>
            {/if}
            
            {* TIP A FRIEND *}
            {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}
            
            </div>
        </div>
        
        <div class="attributi-base">
    
        
        {def $attributes=''}
    
    {* ------------------------------- file ------------------------------- *}
        {if $node.data_map.file.has_content}
            {set $attributes=array($node.data_map.file)}
            {include name = attributi_principali uri = 'design:parts/openpa/attributi_principali.tpl' contentobject_attributes = $attributes}		
        {/if}	
        
    {* ------------------------------- descrizione ------------------------------- *}
        {if $node.data_map.descrizione.has_content}
            {set $attributes=array($node.data_map.descrizione)}
            {include name = attributi_principali uri = 'design:parts/openpa/attributi_principali.tpl' contentobject_attributes = $attributes}
        {/if}
        
        {* CLASSIFICAZIONE - rispetto ad attributi *}
        {* OGGETTI CORRELATI rispetto ad attributi specifici - $attributi_classificazione_articolo *}   
        {include name=classificazione_strutture 
                    node=$node 
                    title="Classificazione dell'Articolo"
                    attributi_classificazione=$attributi_classificazione_articolo
                    uri='design:parts/classificazione_strutture.tpl'}
    
        {*CORRELAZIONI*}
        {* OGGETTI DIRETTAMENTE CORRELATI rispetto ad attributi specifici - oggetti_correlati_centro*}   
        {include name=related_objects_attributes_spec 
                    node=$node
                    title='Esiste un riferimento con:'
                    oggetti_correlati=$oggetti_correlati_centro 
                    uri='design:parts/related_objects_attributes.tpl'}
    
        {*OGGETTI INVERSAMENTE CORRELATI*}
        {include name=reverse_related_objects 
                node=$node 
                title='Articolo richiamato da:'
                uri='design:parts/reverse_related_objects.tpl'}
    
    
        {* GALLERIA fotografica *} 
        {if $node.data_map.image.has_content}
            {include name=galleria 	titolo="Anteprima dell'articolo (con Zoom)" node=$node scope='attribute' uri='design:node/view/line_gallery.tpl'}
        {/if}
    
        {* FIGLI *}
        {include name=filtered_children 
                        object=$node.object
                        classes_figli=array('file_pdf','news')
                        classes_figli_escludi=array()
                        classes_parent_to_edit=$classes_parent_to_edit
                        title='Allegati'
                        classi_da_non_commentare=$classi_da_non_commentare
                        node=$node.object.main_node oggetti_correlati=$oggetti_correlati 
                        uri='design:parts/filtered_children.tpl'}
    
        </div>
	</div>
</div>
