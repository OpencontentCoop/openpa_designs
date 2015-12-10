{def $show = true()}
{if openpaini( 'GestioneClassi', 'NascondiTuttiUltimaModifica', '' )|eq( 'enabled' )}
    {set $show = false()}
{/if}
{if openpaini( 'GestioneClassi', 'NascondiUltimaModifica', array() )|contains( $node.class_identifier )}
    {set $show = false()}
{/if}
{if $show}
<div class="last-modified">di {$node.object.published|l10n(date)} {if $node.object.modified|gt(sum($node.object.published,86400))}- Ultima modifica: <strong>{$node.object.modified|l10n(date)}{/if}</strong></div>
{/if}

{if and( is_set( $node.object.data_map.cod_servizio ), $node.object.data_map.cod_servizio.content|gt( 0 ) )}
<div class="last-modified">Codice: 
    <strong>
        {attribute_view_gui attribute=$node.object.data_map.cod_servizio} 
        {if gt($node.object.data_map.cod_incarico,0)} .{attribute_view_gui attribute=$node.object.data_map.cod_incarico} {/if}
        {if gt($node.object.data_map.cod_ufficio,0)} .{attribute_view_gui attribute=$node.object.data_map.cod_ufficio} {/if}
        {if gt($node.object.data_map.cod_struttura,0)} .{attribute_view_gui attribute=$node.object.data_map.cod_struttura} {/if}
        {if gt($node.object.data_map.cod_altrastruttura,0)} .{attribute_view_gui attribute=$node.object.data_map.cod_altrastruttura} {/if}
    </strong>
</div>    
{/if}