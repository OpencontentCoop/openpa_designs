{*
	TEMPLATE ALLEGATI E ANNESSI

	node	nodo di riferimento
	title	titolo del blocco
	attributi_rilevanti	array degli attributi da evidenziare
*}

{def $trovati_allegati = false()
     $style='col-odd'}
     
{set-block variable=allegati}
    {foreach $node.object.contentobject_attributes as $attribute}
        {if and($attributi_rilevanti|contains($attribute.contentclass_attribute_identifier), $attribute.has_content)}
            {if $attribute.data_type_string|ne('ezselection')}
                {set $trovati_allegati=true()}                
                <tr>
                    <th>{$attribute.contentclass_attribute_name}</th>
                    <td>{attribute_view_gui attribute=$attribute}</td>
                </tr>
            {else}
                {set $trovati_allegati=true()}                
                <tr>
                    <th>{$attribute.contentclass_attribute_name}</th>
                    <td>{attribute_view_gui attribute=$attribute}</td>
                </tr>
            {/if}
        {/if}
    {/foreach}
{/set-block}

{if $trovati_allegati}
<div class="panel panel-default panel-allegati">
    <div class="panel-heading">
        <h2>{$title}</h2>
    </div>
    <table class="table">
    {$allegati}
    </table>
</div>
	
{/if}