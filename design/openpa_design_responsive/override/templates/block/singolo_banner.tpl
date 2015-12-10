{def $valid_node = $block.valid_nodes[0]}

{if and( is_set($valid_node.data_map.location), $valid_node.data_map.location.has_content )}
    {def $collegamento = $valid_node.data_map.location.content}
{elseif and( is_set($valid_node.data_map.location_applicativo), $valid_node.data_map.location_applicativo.has_content )}
    {def $collegamento = $valid_node.data_map.location_applicativo.content}
{else}
	{def $collegamento = $valid_node.url_alias|ezurl()}
{/if}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
    {if $block.name}
    <h2><a href={$collegamento} title="Collegati a '{$valid_node.name|wash()}' in una nuova pagina">{$block.name}</a></h2></h2>
    {/if}
    <div class="col-md-4">
        {if and( is_set($valid_node.data_map.image), $valid_node.data_map.image.has_content )}
        {attribute_view_gui href=$collegamento alt=$valid_node.name|wash() attribute=$valid_node.data_map.image image_class='ezflowmediablock' }
        {/if}
    </div>
    <div class="col-md-8">
        <h3><a href={$collegamento}>{$valid_node.name|wash()}</a></h3>
        {if $valid_node|has_abstract()}
            {$valid_node|abstract()}
            <p><a href={$valid_node.url_alias|ezurl()} title="Dettagli di {$valid_node.name|wash()}">> DETTAGLI DELLA NEWS</a></p>
        {/if}
    </div>
</div>    

{undef $collegamento}