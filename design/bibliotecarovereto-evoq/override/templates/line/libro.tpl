{def $targets = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id, 'all_relations', false(), 'attribute_identifier', 'event/target' ) )
     $types = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id, 'all_relations', false(), 'attribute_identifier', 'event/tipo_evento' ) )
     $item_class = array()}
<div class="row">
    <div class="col-sm-4">
        {if $node|has_attribute( 'image' )}
            <a href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
                {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='book_line' css_class=false() image_css_class="img-responsive"}
            </a>
        {else}
            <img class="img-responsive" src="{'placeholder.png'|ezimage( 'no' )}" alt="Immagine non disponibile">
        {/if}
    </div>
    <div class="col-sm-8">
        <article>
            <header>
                <a href="{$node.url_alias|ezurl('no')}"><h3>{$node.name|wash()}</h3></a>
                <p>
                    <a href="{concat($node.parent.url_alias|ezurl(no), '/(attribute', $node.data_map.autori.contentclassattribute_id, ')/', $node.object.data_map.autori.content, '/(class_id)/', $node.object.contentclass_id)}">{attribute_view_gui attribute=$node|attribute( 'autori' )}</a>
                    {if $node|has_attribute( 'traduttore' )}
                        (traduttore {attribute_view_gui attribute=$node|attribute( 'traduttore' )})
                    {/if}<br>
                    <a href="{concat($node.parent.url_alias|ezurl(no), '/(attribute', $node.data_map.editore.contentclassattribute_id, ')/', $node.object.data_map.editore.content, '/(class_id)/', $node.object.contentclass_id)}">{attribute_view_gui attribute=$node|attribute( 'editore' )}</a>
                </p>
            </header>
            {*
            <div class="text">
                <p>
                    <button type="button" class="btn btn-default btn-block btn-green initialism">Prenotalo ora</button>
                </p>
            </div>
            *}
            <footer>
                {include uri=concat('design:parts/target.tpl')
                 item=$node}
                <p class="ellipsis">
                    <a href="{concat($node.parent.url_alias|ezurl(no), '/(attribute', $node.data_map.tipologia.contentclassattribute_id, ')/', $node.object.data_map.tipologia.class_content.options[$node.object.data_map.tipologia.data_text].name, '/(class_id)/', $node.object.contentclass_id)}" class="category initialism">{attribute_view_gui attribute=$node|attribute( 'tipologia' )}</a>
                </p>
            </footer>
            <div class="clearfix">
                {include uri='design:parts/social_buttons.tpl'}
            </div>
        </article>
    </div>
</div>
