{def $valid_node = $node
     $colors = openpaini( 'BlockBackground', 'Color' )}
{if $index|gt(count($colors)|sub(1))}
    {set $index = rand(1, count($colors)|sub(1))}
{/if}
{def $color = $colors[$index]}

<div class="ezpage-block color color-{$color}">    
    <h2><a href={$valid_node.url_alias|ezurl()} title="Link a {$valid_node.name|wash()}">{$valid_node.name|wash()}</a></h2>
    {if $valid_node|has_abstract()}
        
        <p>
            {$valid_node|abstract()|openpa_shorten(400)}
        </p>
        
        <p class="link"><a href={$valid_node.url_alias|ezurl()} title="Dettagli di {$valid_node.name|wash()}">VEDI DETTAGLI</a></p>
    {/if}
</div>