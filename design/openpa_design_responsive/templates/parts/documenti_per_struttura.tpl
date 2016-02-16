{*

	classe_filtro classe per cui cercare con ezfind gli oggetti correlati, con facette
	node= nodo di provenienza

*}

{def $items = fetch( 'openpa', 'faccette_classi_oggetti_correlati_inversi', hash( 'object', $node.object,
                                                                                     'class_filter_type', 'exclude',
                                                                                     'class_filter_array', openpaini( 'GestioneClassi', 'classi_da_escludere_da_blocco_ezfind', array() )
                                                                                    ) )}

{if count( $items )|gt(0)}
<div class="panel panel-default panel-documenti-per-struttura">
    <div class="panel-heading">
        <h2>Riferibili a {$node.name}</h2>
    </div>
    <table class="table">
        {foreach $items as $item}
            {foreach $item as $data}
                <tr><td>
                    <a href="{concat( "content/advancedsearch?filter[]=", solr_meta_subfield( $data.attribute_identifier, 'main_node_id' ), ':', $node.node_id|urlencode, '&filter[]=contentclass_id:', $data.class_id, "&SearchButton=Cerca")|ezurl(no)}" title="Link a {$data.class_name|wash}">{$data.class_name|wash} {if count($item)|gt(1)}<small>{$data.attribute_name}</small>{/if} ({$data.value})</a>
                </td></tr>
            {/foreach}
        {/foreach}
    </table>
</div>
{/if}
