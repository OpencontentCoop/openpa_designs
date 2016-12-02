
<article>
    <header>
        <a href="{$node.url_alias|ezurl('no')}"><h3>{$node.name|wash()}</h3></a>
    </header>
    <div class="text">
        {$node.object.data_map.description.content.output.output_text|striptags|shorten(200, '...')}
    </div>
    {if $node|has_attribute( 'image' )}
        <a href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='patrimonio_line' css_class="img-responsive"}
        </a>
    {/if}
</article>
