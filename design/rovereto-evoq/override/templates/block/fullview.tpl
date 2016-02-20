{def $node = $block.valid_nodes[0]}
{include name=buttons node=$node uri='design:parts/openpa/edit_buttons.tpl' css_class="pull-right"} 

{def $attributi_da_escludere = openpaini( 'GestioneAttributi', 'attributi_da_escludere' )
     $oggetti_senza_label = openpaini( 'GestioneAttributi', 'oggetti_senza_label' )
     $attributi_senza_link = openpaini( 'GestioneAttributi', 'attributi_senza_link' )
     $attributi_da_evidenziare = openpaini( 'GestioneAttributi', 'attributi_da_evidenziare', array())}


{foreach $node.data_map as $attribute}
    
    {if and( $attribute.has_content, $attribute.content|ne('0') )}
    
        {if $attributi_da_escludere|contains( $attribute.contentclass_attribute_identifier )|not()}
            
            {if and( flip_exists( $attribute.contentobject_id, $attribute.version ), $attribute.contentclass_attribute_identifier|eq( 'file' ) )}
                {set $oggetti_senza_label = $oggetti_senza_label|append( $attribute.contentclass_attribute_identifier )}
            {/if}
            
            
            {if $oggetti_senza_label|contains( $attribute.contentclass_attribute_identifier )|not()}
               <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
                    <div class="col-md-3 attribute-label">{$attribute.contentclass_attribute_name}</div>
                    <div class="col-md-9">
                        {if $attributi_senza_link|contains( $attribute.contentclass_attribute_identifier )}
                            {attribute_view_gui href='nolink' attribute=$attribute}
                        {else}
                            {attribute_view_gui attribute=$attribute}
                        {/if}
                    </div>
               </div>
            {else}
               <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
                <div class="col-md-12">
                    {if $attributi_senza_link|contains( $attribute.contentclass_attribute_identifier )}
                        {attribute_view_gui href='nolink' attribute=$attribute show_flip=true()}
                    {else}
                        {attribute_view_gui attribute=$attribute show_flip=true()}
                    {/if}
                </div>
               </div>
            {/if}
        {/if} 
    {else}
        {if $attribute.contentclass_attribute_identifier|eq('ezflowmedia')}				
            <div class="row attribute-fullbase-{$attribute.contentclass_attribute_identifier}">
                <div class="col-md-12">
                {attribute_view_gui attribute=$attribute}
                </div>
            </div>
        {/if}		
    {/if}
{/foreach}


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


{* GALLERIA fotografica *}   
{def $galleriesImages = fetch('content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                             'class_filter_type', 'include',
                                                             'class_filter_array', array('image') ) )
     $galleriesImagesInMainNode = array()}        
{if and( $galleriesImages|eq(0), $node.node_id|ne( $node.object.main_node_id ) )}
    {set $galleriesImagesInMainNode = fetch('content', 'list_count', hash( 'parent_node_id', $node.object.main_node_id,
                                                                           'class_filter_type', 'include',
                                                                           'class_filter_array', array('image') ) )}
{/if}        
{def $galleries = fetch('content', 'list', hash( 'parent_node_id', $node.node_id,    
                                                 'limit', 1,
                                                 'class_filter_type', 'include',
                                                 'class_filter_array', array('gallery') ) )}    
{if $galleriesImages|gt(0)}
    {include name=galleria node=$node uri='design:node/view/line_gallery.tpl'}
{elseif $galleriesImagesInMainNode|gt(0)}
    {include name=galleria node=$node.object.main_node uri='design:node/view/line_gallery.tpl'}
{elseif $galleries|count()|gt(0)}
    {include name=galleria node=$galleries[0] uri='design:node/view/line_gallery.tpl'}
{/if}
