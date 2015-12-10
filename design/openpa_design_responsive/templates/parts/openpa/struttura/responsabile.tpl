{def $role_folder = openpaini( 'ControlloUtenti', 'role_folder' )
     $role_struttura_attribute_ID = openpaini( 'ControlloUtenti', 'role_struttura_attribute_ID' )}
{def $resp_correlati_byrole = fetch('content','list', hash('parent_node_id', $role_folder, 'extended_attribute_filter',  hash('id', 'ObjectRelationFilter', 'params', array($role_struttura_attribute_ID,$node.object.id) ) ) )}
        
{if $resp_correlati_byrole|count()}
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
{elseif and( is_set($node.data_map.responsabile), $node.data_map.responsabile.has_content )}
    <div class="row attribute-responsabile">
        <div class="col-md-3 attribute-label">{$node.data_map.responsabile.contentclass_attribute_name}</div>
        <div class="col-md-9">
            {attribute_view_gui attribute=$node.data_map.responsabile}
        </div>
    </div>                                
{/if}		 