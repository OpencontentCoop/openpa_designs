<article class="content-view-line class-{$node.class_identifier}">
    <header>
        {if is_set( $node.url_alias )}
            <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}"><h3>{$node.name|wash()}</h3></a>
        {else}
            {$node.name|wash()}
        {/if}
    </header>
    <div class="text">
    {if $node|has_abstract()}
        {attribute_view_gui attribute=$node|attribute( 'abstract' )}
    {/if}
    </div>
    {if $node|has_attribute( 'image' )}
        <a href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='patrimonio_line' css_class=false() image_css_class="img-responsive"}
        </a>
    {/if}
</article>
