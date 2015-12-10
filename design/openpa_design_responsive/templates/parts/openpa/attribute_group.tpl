{def $oggetti_senza_label = openpaini( 'GestioneAttributi', 'oggetti_senza_label' )}
<div class="row attribute-contatti{if is_set($css_class)} {$css_class}{/if}">
    {if is_set($title)}<div class="col-md-3 attribute-label">{$title}</div>{/if}
    <div class="col-md-{if is_set($title)}9{else}12{/if}">
        {foreach $identifiers as $identifier}
            {if and( is_set( $node.data_map[$identifier] ), $node.data_map[$identifier].has_content, $node.data_map[$identifier].content|ne('0') )}
                {if $node.data_map[$identifier].data_type_string|ne('ezgmaplocation')}<p>{/if}
                    {if $oggetti_senza_label|contains( $node.data_map[$identifier].contentclass_attribute_identifier )|not()}
                        <strong>{$node.data_map[$identifier].contentclass_attribute_name}:</strong>
                    {/if}
                    {attribute_view_gui attribute=$node.data_map[$identifier]}
                {if $node.data_map[$identifier].data_type_string|ne('ezgmaplocation')}</p>{/if}
            {/if}
        {/foreach}            
    </div>
</div>