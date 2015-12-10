{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $attributi_da_evidenziare = openpaini( 'GestioneAttributi', 'attributi_da_evidenziare' )
	 $attributi_a_destra = openpaini( 'GestioneAttributi', 'attributi_a_destra' )
	 $classes_parent_to_edit = openpaini( 'GestioneClassi', 'classi_figlie_da_editare' )}


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
             title = 'Informazioni correlate:'
             oggetti_correlati = openpaini( 'DisplayBlocks', 'oggetti_correlati_centro' )
             uri = 'design:parts/related_objects_attributes.tpl'}


    {* FIGLI: ALLEGATI *}
    {include name = filtered_children 
             node = $node.object.main_node 
             object = $node.object
             classes_figli = openpaini( 'GestioneClassi', 'classi_figlie_da_includere' )
             classes_figli_escludi = openpaini( 'GestioneClassi', 'classi_figlie_da_escludere' )
             classes_parent_to_edit = $classes_parent_to_edit
             title='Allegati'
             classi_da_non_commentare = openpaini( 'GestioneClassi', 'classi_da_non_commentare', array( 'news', 'comment' ) )
             oggetti_correlati = openpaini( 'DisplayBlocks', 'oggetti_correlati' )
             uri = 'design:parts/filtered_children.tpl'}
             

    {*OGGETTI INVERSAMENTE CORRELATI*}
    {include name = reverse_related_objects 
             node = $node 
             title = 'Riferimenti:'
             uri = 'design:parts/reverse_related_objects.tpl'}

	{* GALLERIA fotografica *}   
	{def $galleries = fetch('content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                           'class_filter_type', 'include',
                                                           'class_filter_array', array('image') ) )}
	{if $galleries|gt(0)}
		{include name=galleria node=$node uri='design:node/view/line_gallery.tpl'}
	{/if}


    
    {* TIP A FRIEND *}
    {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}    
	
    </div>
</div>

