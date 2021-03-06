{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}
	
{def $oggetti_classificazione 	= openpaini( 'DisplayBlocks', 'oggetti_classificazione' )
	 $oggetti_senza_label 		= openpaini( 'GestioneAttributi', 'oggetti_senza_label' )
     $oggetti_correlati_centro 	= openpaini( 'DisplayBlocks', 'oggetti_correlati_centro' )
	 $attributi_da_includere_user 	= openpaini( 'GestioneAttributi', 'attributi_da_includere_user' )
	 $attributi_da_evidenziare 	= openpaini( 'GestioneAttributi', 'attributi_da_evidenziare' )
	 $attributi_sotto   		= openpaini( 'GestioneAttributi', 'attributi_sotto_user' )
	 $attributi_allegati_atti 	= openpaini( 'GestioneAttributi', 'attributi_allegati_atti' )
	 $classes_figli 			= openpaini( 'GestioneClassi', 'classi_figlie_da_includere' )
	 $classes_figli_escludi  	= openpaini( 'GestioneClassi', 'classi_figlie_da_escludere' )
	 $classi_commentabili 		= openpaini( 'GestioneClassi', 'classi_commentabili' )
	 $classes_parent_to_edit 	= array('file_pdf', 'news')
	 $classi_da_non_commentare 	= array('news', 'comment')
	 $classi_senza_correlazioni_inverse = openpaini( 'GestioneClassi', 'classi_senza_correlazioni_inverse' )
	 $current_user 			= fetch( 'user', 'current_user' )
}

<div class="border-box">
<div class="border-content">

 <div class="global-view-full content-view-full">
  <div class="class-{$node.object.class_identifier}">

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

    {*OGGETTI INVERSAMENTE CORRELATI - RUOLI *}
	 {include name=reverse_related_objects_specific_class_and_attribute_asText
				node=$node
				classe='ruolo'
				attrib='utente' 
				title="Ruolo"
				href="nolink"
				uri='design:parts/reverse_related_objects_specific_class_and_attribute_asText.tpl'}	
	
	<div class="attributi-base">
        {def $style='col-odd'}
            {foreach $node.object.contentobject_attributes as $attribute}
            {if $attribute.has_content}
                {if $attributi_da_includere_user|contains($attribute.contentclass_attribute_identifier)}
                    {if $style|eq('col-even')}{set $style='col-odd'}{else}{set $style='col-even'}{/if}
                    {if $oggetti_senza_label|contains($attribute.contentclass_attribute_identifier)|not()}
                       <div class="{$style} col float-break attribute-{$attribute.contentclass_attribute_identifier}">
                            <div class="col-title"><span class="label">{$attribute.contentclass_attribute_name}</span></div>
                            <div class="col-content"><div class="col-content-design">
                                {attribute_view_gui attribute=$attribute}
                            </div></div>
                       </div>
                    {else}
                       <div class="{$style} col col-notitle float-break attribute-{$attribute.contentclass_attribute_identifier}">
                        <div class="col-content"><div class="col-content-design">
                            {attribute_view_gui attribute=$attribute}
                        </div></div>
                       </div>
                    {/if}
                {/if}			
            {/if}
        {/foreach}
    
        {foreach $node.object.contentobject_attributes as $attribute}
            {if $attributi_sotto|contains($attribute.contentclass_attribute_identifier)}
                {if $attribute.has_content}
                    {if $attribute.content|ne(0)}
                    {if $style|eq('col-even')}{set $style='col-odd'}{else}{set $style='col-even'}{/if}
                       <div class="{$style} col float-break attribute-{$attribute.contentclass_attribute_identifier}">
                            <div class="col-title"><span class="label"> </span></div>
                            <div class="col-content"><div class="col-content-design">
                                {$attribute.contentclass_attribute_name}
                            </div></div>
                       </div>
                    
                    {/if}
                    
                {/if}
            {/if}
        {/foreach}
	</div>

    {*OGGETTI INVERSAMENTE CORRELATI - RUOLI *}
	 {include name=reverse_related_objects_specific_class_and_attribute
				node=$node
				classe="ruolo"
				attrib="utente" 
				title="Ruolo"
				href="nolink"
				uri='design:parts/reverse_related_objects_specific_class_and_attribute.tpl'}	

    {*CORRELAZIONI*}
	{* OGGETTI DIRETTAMENTE CORRELATI rispetto ad attributi specifici - oggetti_correlati_centro*}   
	{include name=related_objects_attributes_spec 
				node=$node
				title='Ulteriori informazioni correlate:'
				oggetti_correlati=$oggetti_correlati_centro 
				uri='design:parts/related_objects_attributes.tpl'}


    {*OGGETTI CORRELATI SPECIFICI - CLASSIFICAZIONE*}
	{* OGGETTI CORRELATI rispetto ad attributi specifici - oggetti_classificazione *}   
	{include name=related_objects_attributes 
				node=$node 
				title="Posizionamento nell'organigramma"
				oggetti_correlati=$oggetti_classificazione 
				uri='design:parts/related_objects_attributes.tpl'}


    {*OGGETTI INVERSAMENTE CORRELATI - TELEFONI *}
	 {include name=reverse_related_objects_specific_class_and_attribute
				node=$node
				classe='telefono'
				attrib='utente' 
				title="Recapito telefonico"
				href="nolink"
				uri='design:parts/reverse_related_objects_specific_class_and_attribute.tpl'}	

    {*FIGLI*}
    {include name=filtered_children 
					object=$node.object
					node=$node
					classes_figli=$classes_figli
					classes_figli_escludi=$classes_figli_escludi
					classes_parent_to_edit=$classes_parent_to_edit
					title='Curriculum vitae'
					classi_da_non_commentare=$classi_da_non_commentare
					uri='design:parts/filtered_children.tpl'}


    {* GALLERIA fotografica *}   
	{def $galleries = fetch('content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                           'class_filter_type', 'include',
                                                           'class_filter_array', array('image') ) )}
	{if $galleries|gt(0)}
		{include name=galleria node=$node uri='design:node/view/line_gallery.tpl'}
	{/if}


    {* TIP A FRIEND *}
    {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}

    {* VISUALIZZAZIONE E CREAZIONE DI NEWS *}
    {if $node.object.content_class.is_container}
		{include name = create_comment 
				 node = $node
                 object=$node.object
				 classes_parent_to_edit = $classes_parent_to_edit
				 classi_da_non_commentare = openpaini( 'GestioneClassi', 'classi_da_non_commentare', array( 'news', 'comment' ) )
				 uri = 'design:parts/websitetoolbar/create_news.tpl'}

    {/if}
    
	{* COMMENTI *}
    {if openpaini( 'GestioneClassi', 'classi_commentabili' )|contains($node.class_identifier)}
		{include name=create_comment node=$node uri='design:parts/websitetoolbar/create_comment.tpl'}
  	{/if}
	
    </div>
</div>

</div>
</div>