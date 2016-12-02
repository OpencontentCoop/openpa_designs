{def $openpa= object_handler($block)}
{set_defaults(hash('show_title', true()))}

<div class="container last-news">
{if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}
{if and( $show_title, $block.name|ne('') )}
    <div class="row">
        <div class="col-md-12">
            <h2>Ultime notizie</h2>
        </div>
    </div>
{/if}
{def $first_item = $openpa.content[0]}
<div class="row">
    <div class="col-md-4">
        {* Immagine *}
        {if $first_item|has_attribute( 'image' )}
            {attribute_view_gui attribute=$first_item|attribute( 'image' )}
        {elseif and($first_item|has_attribute( 'immagini' ), $first_item.data_map.immagini.has_content)}
            {def $image_node = fetch( 'content', 'node', hash( 'node_id', $first_item.data_map.immagini.content.relation_list[0].node_id ) )}
            {attribute_view_gui attribute=$image_node|attribute( 'image' )}
            {undef $image_node}
        {/if}
        <h3><a href="{$first_item.url_alias|ezurl(no)}">{$first_item.name}</a></h3>
        <div>
            {$first_item.data_map.testo_completo.content.output.output_text|openpa_shorten(270)} <a class="continue-reading pull-right" href="{$first_item.url_alias|ezurl(no)}">[...]</a>
        </div>
        <br />
        {attribute_view_gui attribute=$first_item|attribute( 'tematica' )}
        <div class="row">
            <div class="col-md-12">
                <br />
                <small>{$first_item.object.published|l10n(date)}</small>
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            {def $count = 1}
            {foreach $openpa.content as $item offset 1}
                <div class="col-md-6">
                    <div class="class-{$item.class_identifier} media {$item|access_style}">
                        {if $item|has_attribute( 'image' )}

                        {/if}

                        {if $item|has_attribute( 'image' )}
                            <a class="pull-left hidden-xs" href="{if is_set( $item.url_alias )}{$item.url_alias|ezurl('no')}{else}#{/if}">
                                {attribute_view_gui attribute=$item|attribute( 'image' ) href=false() image_class='small' css_class="media-object"}
                            </a>
                        {elseif and($first_item|has_attribute( 'immagini' ), $first_item.data_map.immagini.has_content)}

                            {def $image_node = fetch( 'content', 'node', hash( 'node_id', $item.data_map.immagini.content.relation_list[0].node_id ) )}
                            <a class="pull-left hidden-xs" href="{if is_set( $item.url_alias )}{$item.url_alias|ezurl('no')}{else}#{/if}">
                                {attribute_view_gui attribute=$image_node|attribute( 'image' ) href=false() image_class='small' css_class="media-object"}
                            </a>
                            {undef $image_node}
                        {/if}

                        <div class="media-body">
                            <h4 class="media-heading"><a href="{$item.url_alias|ezurl(no)}">{$item.name|wash()}</a></h4>

                            <div>
                                {$item.data_map.testo_completo.content.output.output_text|openpa_shorten(135)} <a class="continue-reading pull-right" href="{$item.url_alias|ezurl(no)}">[...]</a>
                            </div>
                            <br />
                            {attribute_view_gui attribute=$item|attribute( 'tematica' )}
                        </div>
                    </div>
                </div>
                {if $count|mod(2)|eq(0)}
                    </div><div class="row">
                {/if}
                {set $count = $count|sum(1)}
            {/foreach}
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12 text-right">
        <a href="{$first_item.parent.url_alias|ezurl(no)}">Guarda tutti gli elementi di questa sezione</a>
    </div>
</div>

{if is_set($block.custom_attributes.color_style)}</div>{/if}
</div>