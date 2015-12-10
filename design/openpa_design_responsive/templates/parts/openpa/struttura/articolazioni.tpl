{def $attributi_classificazione = openpaini( 'DisplayBlocks', 'attributi_classificazione_strutture' )		
     $has_content=false()}

{def $attributes = $node.object.contentobject_attributes}
{foreach $attributes as $attribute}
{if and( $attributi_classificazione|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
    {set $has_content = true()}
{/if}
{/foreach}

{set-block variable=$articolazioni}
{include node=$node icon=true uri='design:parts/articolazioni_interne.tpl'}
{/set-block}

{if or( $has_content, has_html_content($articolazioni) )}
<div class="panel panel-default">
    <div class="panel-heading">
        <h2>Posizionamento nell'organigramma</h2>
    </div>

    {if $has_content}
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
    {/if}
    {undef $has_content $attributes}
    
    {if has_html_content($articolazioni)}
    <div class="panel-body">
        <ul class="org-chart margin-top">
            <li>
                <div class="vcard"><strong>{$node.name|wash()}</strong></div>
                {$articolazioni}
            </li>
        </ul>
    </div>
    {/if}
</div>
{/if}