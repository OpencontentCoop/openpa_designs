{def $user_struttura_attribute_ID = openpaini( 'ControlloUtenti', concat('user_',$node.class_identifier,'_attribute_ID') )
     $dipendenti_correlati=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.object.id,
                                                                              'attribute_identifier', $user_struttura_attribute_ID, 	
                                                                              'sort_by',  array( 'name', true() )) )        
     $informatici_correlati=fetch( 'content', 'list', hash( 'parent_node_id',  openpaini( 'ControlloUtenti', 'referenti_informatici' ),
                                                            'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 'params', array( $user_struttura_attribute_ID, $node.object.id )),
                                                            'sort_by',  array( 'name', true() )) )
     $editor_correlati=fetch( 'content', 'list', hash( 'parent_node_id',  openpaini( 'ControlloUtenti', 'redattori' ),
                                                       'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 'params', array( $user_struttura_attribute_ID, $node.object.id )),
                                                       'sort_by',  array( 'name', true() )) )}		

{if $dipendenti_correlati|count()}	

<div class="row attribute-personale">
    
    <div class="col-md-3 attribute-label">{cond(is_set($title),$title,'Personale')}</div>
    <div class="col-md-9">

        
        {foreach $dipendenti_correlati as $object_correlato}
            {if $object_correlato.can_read}
            <dl class="dl-horizontal">    
                <dt><a href={$object_correlato.main_node.url_alias|ezurl()}>{$object_correlato.name}</a></dt>
    
                {def $telefoni_correlati=fetch('content', 'list', hash('parent_node_id', openpaini( 'ControlloUtenti', 'telefoni' ), 'extended_attribute_filter', hash('id', 'ObjectRelationFilter', 'params', array(openpaini( 'ControlloUtenti', 'utente_telefono_attribute_ID' ), $object_correlato.id) ) ) )}
                {if $telefoni_correlati|count()}
                    {foreach $telefoni_correlati as $tel_correlato}
                        <dd>
                            {$tel_correlato.name} 					
                            {if $tel_correlato.data_map.numero_interno.has_content}
                                (interno: {attribute_view_gui attribute=$tel_correlato.data_map.numero_interno})
                            {/if}
                        </dd>
                    {/foreach}
                
                {elseif is_set( $object_correlato.data_map.telefono )}
                    <dd>{attribute_view_gui attribute=$object_correlato.data_map.telefono}</dd>
                {/if}
                
                {undef $telefoni_correlati}
            </dl>
            {/if}
        {/foreach}
        
        
        {if $informatici_correlati|count()}	
        <h5>Referenti informatici</h5>
        <ul class="list-unstyled">
        {foreach $informatici_correlati as $object_correlato}
             <li><a href={$object_correlato.url_alias|ezurl()}>{$object_correlato.name}</a></li>     
        {/foreach}
        </ul>
        {/if}
        
        {if $editor_correlati|count()}	
        <h5>Redattori sito/intranet</h5>
        <ul class="list-unstyled">
        {foreach $editor_correlati as $object_correlato}
             <li><a href={$object_correlato.url_alias|ezurl()}>{$object_correlato.name}</a></li>        
        {/foreach}
        </ul>
        {/if}

    </div>
</div>

{/if}