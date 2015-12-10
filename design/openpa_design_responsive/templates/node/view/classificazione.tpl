{def $link_classes = array( 'servizio', 'ufficio', 'area', 'modulo', 'link' )}
<div class="content-view-embed">        
    {if $link_classes|contains( $node.class_identifier )}
        <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
    {else}
        {$node.name|wash()}
    {/if}    
</div>
