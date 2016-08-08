{set_defaults(hash('image_class', 'small'))}
<div class="class-{$node.class_identifier} media {$node|access_style}">

    {if $node|has_attribute( 'image' )}
        <a class="pull-left hidden-xs" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class=$image_class css_class="media-object"}
        </a>
    {elseif and($node|has_attribute( 'immagini' ), $node.data_map.immagini.has_content)}
        {def $image_node = fetch( 'content', 'node', hash( 'node_id', $node.data_map.immagini.content.relation_list[0].node_id ) )}
            <a class="pull-left hidden-xs" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
                {attribute_view_gui attribute=$image_node|attribute( 'image' ) href=false() image_class=$image_class css_class="media-object"}
            </a>
        {undef $image_node}
    {/if}
    <div class="media-body">
        <h3 class="media-heading">
            <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
        </h3>

        <div>
            {$node.data_map.testo_completo.content.output.output_text|openpa_shorten(135)}
        </div>

    </div>
</div>
