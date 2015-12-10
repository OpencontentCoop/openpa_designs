{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $oggetti_classificazione = array('organo_politico')
	 $oggetti_correlati_centro = array('struttura')
	 $classes_parent_to_edit=array( 'file_pdf', 'news')
	 $classi_da_non_commentare=array( 'news', 'comment')
	 $current_user = fetch( 'user', 'current_user' )
}

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
                 
        {* ATTRIBUTI BASE: mostra i contenuti del nodo *}
        {include name = attributi_base
                 uri = 'design:parts/openpa/attributi_base.tpl'
                 node = $node}
        
        {* CORRELAZIONI - OGGETTI DIRETTAMENTE CORRELATI rispetto ad attributi specifici - DisplayBlocks/oggetti_correlati_centro *}   
        {include name = related_objects_attributes_spec 
                 node = $node
                 title = 'Struttura di riferimento'
                 oggetti_correlati = $oggetti_correlati_centro 
                 uri = 'design:parts/related_objects_attributes.tpl'}
    
        {* ALLEGATI E ANNESSI DI ATTI RELAZIONATI: iter, pareri, allegati di ATTI ecc *}
        {include name = allegati_e_annessi
                 node = $node 
                 title = 'Relazioni'
                 attributi_rilevanti = openpaini( 'GestioneAttributi', 'attributi_allegati_atti' )
                 uri = 'design:parts/allegati_e_annessi.tpl'}
      
    
        {* OGGETTI CORRELATI rispetto ad attributi specifici - oggetti_classificazione *}   
        {include name=related_objects_attributes 
                    node=$node 
                    title="Organi e strutture di riferimento"
                    oggetti_correlati=$oggetti_classificazione 
                    uri='design:parts/related_objects_attributes.tpl'}
    
        {* FIGLI *}
        {include name = filtered_children 
                 node = $node.object.main_node 
                 classes_figli = array('politico')
                 title=false()
                 uri = 'design:parts/filtered_children.tpl'}
    
        {include name = filtered_children 
                 node = $node.object.main_node 
                 classes_figli = openpaini( 'GestioneClassi', 'classi_figlie_da_includere' )
                 title='Allegati'
                 uri = 'design:parts/filtered_children.tpl'}
    
        {include name = filtered_children 
                 node = $node.object.main_node 
                 classes_figli = array('news')
                 title='News'
                 uri = 'design:parts/filtered_children.tpl'}
                 
    
    
        {* GALLERIA fotografica *}   
        {def $galleries = fetch('content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                               'class_filter_type', 'include',
                                                               'class_filter_array', array('image') ) )}
        {if $galleries|gt(0)}
            {include name=galleria node=$node uri='design:node/view/line_gallery.tpl'}
        {/if}
        
        {def $sale_pubbliche = fetch( ezfind, search, hash( 'subtree_array', array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ),
                                                            'sort_by', hash( 'name', 'asc' ),
                                                            'class_id', array( 'sala_pubblica' ),
                                                            'load_data_map', false(),
                                                            'filter', array( concat( 'submeta_circoscrizione___id_si:', $node.contentobject_id ) ) ) )}
        {if $sale_pubbliche.SearchCount|gt(0)}
            <div class="filtered-children">
                <h2>Sale pubbliche</h2>
                <ul>
                    {foreach $sale_pubbliche.SearchResult as $item}
                        <li><a href={$item.url_alias|ezurl()} title="{$item.name|wash()}">{$item.name|wash()}</a></li>
                    {/foreach}
                </ul>
            </div>
        {/if}
    
    
        {* TIP A FRIEND *}
        {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}

    </div>	
</div>
