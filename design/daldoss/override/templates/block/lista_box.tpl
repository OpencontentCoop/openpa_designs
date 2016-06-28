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
        {attribute_view_gui attribute=$first_item|attribute( 'image' )}
        <h3><a href="{$first_item.url_alias|ezurl(no)}">{$first_item.name}</a></h3>
        <div class="abstract">
            {$first_item.data_map.descrizione.content.output.output_text|openpa_shorten(270)} <a class="continue-reading pull-right" href="{$first_item.url_alias|ezurl(no)}">[...]</a>
        </div>
        <ul class="tags list-unstyled list-inline">
            <li><a href="#">sicurezza</a></li>
        </ul>
        <div class="row">
            <div class="col-md-12">
                <small>{$first_item.object.published||l10n(date)}</small>
                {*<small class="pull-right"><i class="fa fa-comments" aria-hidden="true"></i> 55 commenti</small>*}
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="row">
            {def $count = 1}
            {foreach $openpa.content as $item}
                <div class="col-md-6">
                    <div class="class-{$item.class_identifier} media {$item|access_style}">
                        {if $item|has_attribute( 'image' )}
                            <a class="pull-left hidden-xs" href="{if is_set( $item.url_alias )}{$item.url_alias|ezurl('no')}{else}#{/if}">
                                {attribute_view_gui attribute=$item|attribute( 'image' ) href=false() image_class='small' css_class="media-object"}
                            </a>
                        {/if}
                        <div class="media-body">
                            <h4 class="media-heading"><a href="{$item.url_alias|ezurl(no)}">{$item.name|wash()}</a></h4>

                            <div class="abstract">
                                {$item.data_map.descrizione.content.output.output_text|openpa_shorten(135)} <a class="continue-reading pull-right" href="{$item.url_alias|ezurl(no)}">[...]</a>
                            </div>
                            <ul class="tags list-unstyled list-inline">
                                <li><a href="#">sicurezza</a></li>
                            </ul>
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
        <a href="{$firt_item.parent.url_alias|ezurl(no)}">Guarda tutti gli elementi di questa sezione</a>
    </div>
</div>

{if is_set($block.custom_attributes.color_style)}</div>{/if}
</div>