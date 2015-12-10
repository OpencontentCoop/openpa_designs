{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $dirigenti_struttura = openpaini( 'ControlloUtenti', concat('dirigenti_',$node.class_identifier) )	 
     $user_struttura_attribute_ID = openpaini( 'ControlloUtenti', concat('user_',$node.class_identifier,'_attribute_ID') )
     $role_folder = openpaini( 'ControlloUtenti', 'role_folder' )
	 $role_struttura_attribute_ID = openpaini( 'ControlloUtenti', 'role_struttura_attribute_ID' )}

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
        
        <div class="attributi-principali">
        {if $node.data_map.competenze.has_content}
            {attribute_view_gui attribute=$node.data_map.competenze}
        {/if}
        </div>
        
        <div class="attributi-base">

            {* CONTATTI *}            
            {include name=attribute_group
                     node=$node
                     identifiers=array( 'sede', 'indirizzo', 'telefoni', 'fax', 'email', 'email2', 'email_certificata', 'orario', 'gps', 'ubicazione', 'riferimenti_utili', 'file', 'circoscrizione' )
                     uri='design:parts/openpa/attribute_group.tpl'
                     title='Riferimenti'
                     css_class='highlight'}
            
            {* RESPONSABILE *}            
            {def $resp_correlati = fetch( 'content', 'list', hash( 'parent_node_id', $dirigenti_struttura, 'extended_attribute_filter',  hash('id', 'ObjectRelationFilter', 'params', array( $user_struttura_attribute_ID, $node.object.id ) ) ) )
                 $resp_correlati_byrole = fetch('content','list', hash('parent_node_id', $role_folder, 'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 'params', array($role_struttura_attribute_ID,$node.object.id) ) ) )}
            
            {if or( $resp_correlati|count(), $resp_correlati_byrole|count(), and( is_set( $node.data_map.responsabile ), $node.data_map.responsabile.has_content ) )}
                {if $resp_correlati|count()}
                    <div class="row attribute-responsabile">
                        <div class="col-md-3 attribute-label">Responsabile</div>
                        <div class="col-md-9">
                            {foreach $resp_correlati as $object_correlato}                
                                <a href= {$object_correlato.url_alias|ezurl()}>{$object_correlato.name}</a>
                                {delimiter}, {/delimiter}
                            {/foreach}  
                        </div>
                    </div>    
                
                {elseif $resp_correlati_byrole|count()}
                {foreach $resp_correlati_byrole as $object_correlato}	
                    <div class="row attribute-responsabile">
                        <div class="col-md-3 attribute-label">{$object_correlato.name|wash()}</div>
                        <div class="col-md-9">
                            <a href= {$object_correlato.url_alias|ezurl()}>
                                {attribute_view_gui attribute=$object_correlato.data_map.utente}
                            </a>    
                        </div>
                    </div>
                {/foreach}
                
                {elseif $node.data_map.responsabile.has_content}
                    <div class="row attribute-responsabile">
                        <div class="col-md-3 attribute-label">{$node.data_map.responsabile.contentclass_attribute_name}</div>
                        <div class="col-md-9">
                            {attribute_view_gui attribute=$node.data_map.responsabile}
                        </div>
                    </div>                                
                {/if}
            {/if}
            
            {* PERSONALE *}
            {include name=personale uri='design:parts/openpa/struttura/personale.tpl' node=$node title="Contatti"}

    	</div>	
        
        
        {* ARTICOLAZIONI *}
        {include name=articolazioni uri='design:parts/openpa/struttura/articolazioni.tpl' node=$node}

	</div>
</div>
