{*
	Oggetti correlati a partire da un elenco
	node				nodo di riferimento
	title				titolo del blocco
	attributi_classificazione	array di attributi
*}


{def $attributi_classificazione = openpaini( 'DisplayBlocks', 'attributi_classificazione_strutture' )		
     $has_content=false()}

{def $attributes = $node.object.contentobject_attributes}
{foreach $attributes as $attribute}
{if and( $attributi_classificazione|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
    {set $has_content = true()}
{/if}
{/foreach}

{if $has_content}
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>{$title}</h2>
        </div>
        <table class="table">
        {foreach $attributes as $attribute}
            {if and( $attributi_classificazione|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
                <tr>
                    <th>{$attribute.contentclass_attribute_name}</th>
                    <td>{attribute_view_gui attribute=$attribute}</td>
                </tr>
            {/if}
        {/foreach}
        </table>
    </div>
{/if}
{undef $has_content $attributes}