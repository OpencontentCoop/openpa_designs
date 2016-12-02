{*
{def $nodeID = ezhttp( 'nodeID', 'post' )}
<li><a href="#">Menu dettaglio generato in ajax per il nodo {$nodeID}, che non avevndo figli con classi adatte al menu lascerebbe spazio vuoto</a></li>
*}

{if ezhttp( 'nodeID', 'post', true() )}
    
    {def $node = fetch( 'content', 'node', hash( 'node_id', ezhttp( 'nodeID', 'post' ) ) )}
    
    <li class="description">
        <h2><a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a></h2>
        {if $node|has_abstract()}{$node|abstract()}{/if}
    </li>

{/if}