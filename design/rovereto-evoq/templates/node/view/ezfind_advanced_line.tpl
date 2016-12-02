{def $valore = ''}
<tr class="{$sequence}">

<td>
	
    <h4>
        <a href={$node.url_alias|ezurl()}>{$node.name|wash}</a>
        <small>{$node.class_name}</small>
    </h4>
    
    <a href={$node.url_alias|ezurl()}><small>{$node.path_with_names}</small></a>
                
    {if $node|has_abstract()}
    <p>
        {$node|abstract()|openpa_shorten( 200 )}
    </p>
    {/if}
        

</td>


<td>
    {$node.object.published|l10n(date)}
</td>

</tr>
