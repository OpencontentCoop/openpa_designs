{def $attributi_classificazione = openpaini( 'DisplayBlocks', 'attributi_classificazione_strutture' )		
     $has_content=false()}

{def $attributes = $node.object.contentobject_attributes}
{foreach $attributes as $attribute}
{if and( $attributi_classificazione|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
    {set $has_content = true()}
{/if}
{/foreach}

{if $has_content}
    <p class="classificazione-struttura">
    {foreach $attributes as $attribute}    
    {if and( $attributi_classificazione|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
        {attribute_view_gui attribute=$attribute}
    {/if}
    {/foreach}
    </p>
{/if}
{undef $has_content $attributes}

{def $show = true()}
{if openpaini( 'GestioneClassi', 'NascondiTuttiUltimaModifica', '' )|eq( 'enabled' )}
    {set $show = false()}
{/if}
{if openpaini( 'GestioneClassi', 'NascondiUltimaModifica', array() )|contains( $node.class_identifier )}
    {set $show = false()}
{/if}

{if is_section('citta')}
    {set $show = false()}
{/if}

{if and( is_set( $node.data_map.classi_filtro ), $node.data_map.classi_filtro.has_content )}
    {set $show = false()}
{/if}

{if is_area_tematica()}
    {set $show = false()}
{/if}

{if $node.path_array|contains( 6718 )} {*Amminsitrazione trasparente*}
  {set $show = true()}
{/if}

{if $show}
{def $date = $node.object.modified|l10n(date)}
{if $node.object.content_class.is_container}
    {set $date = $node.modified_subnode|l10n(date)}
{/if}
<p class="last-modified">
    <em>Aggiornato a {$date}</em>
    {if and( is_set($node.data_map.data_iniziopubblicazione), $node.data_map.data_iniziopubblicazione.has_content )}
        <br />
        <em>{$node.data_map.data_iniziopubblicazione.contentclass_attribute_name}
            {$node.data_map.data_iniziopubblicazione.content.timestamp|l10n(date)}</em>
    {/if}
  	{if $node.path_array|contains( 6718 )}
	<em>(creato {$node.object.published|l10n(date)})</em>
	{/if}
</p>
{undef $date}
{/if}

