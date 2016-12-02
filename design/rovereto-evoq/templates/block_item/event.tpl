<div class="event ezpage-block">

{attribute_view_gui alt=$node.name|wash() attribute=$node.data_map.image image_class='evoq_singolo_box' href=$node.url_alias|ezurl()}

<h2>    
    <a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
</h2>

<p>
    <strong>
    {if and( is_set( $node.data_map.periodo_svolgimento ), $node.data_map.periodo_svolgimento.has_content )}
        {attribute_view_gui attribute=$node.object.data_map.periodo_svolgimento}
    {else}
        {$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %F")|shorten( 12 , '')}
        {if and($node.object.data_map.to_time.has_content,  ne( $node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M"),
                $node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M") ))}
               - {$node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %F")|shorten( 12 , '')}
        {/if}    
    {/if}
    </strong> 

    {if $node|has_abstract()}
        - {$node|abstract|openpa_shorten(400)} 
    {/if}
</p>

<p class="link"><a href={$node.url_alias|ezurl()} title="Dettagli di {$node.name|wash()}">VEDI DETTAGLI</a></p>

</div>