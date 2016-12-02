<div class="content-view-embed">
	<strong><a href="{$node.url_alias|ezurl(no)}">{$node.name|wash()}</a></strong>
    {if $node|has_abstract()}
        <div class="attibute-text">{$node|abstract()|openpa_shorten( 200 )}</div>
    {/if}
</div>
