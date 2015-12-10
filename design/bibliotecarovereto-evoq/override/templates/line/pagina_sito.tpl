
<article>
    <header>
        <a href="{$node.url_alias|ezurl('no')}"><h3>{$node.name|wash()}</h3></a>
    </header>
    <div class="text">
        {attribute_view_gui attribute=$node|attribute( 'abstract' )}
    </div>
    {if $node|has_attribute( 'image' )}
        <a href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='patrimonio_line' css_class=false() image_css_class="img-responsive"}
        </a>
    {/if}
</article>
