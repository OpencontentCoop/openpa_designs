<li class="col-md-6 item book">
    <div class="row">
        <div class="col-sm-4">
            {if $item|has_attribute( 'image' )}
                <a href="{if is_set( $item.url_alias )}{$item.url_alias|ezurl('no')}{else}#{/if}">
                    {attribute_view_gui attribute=$item|attribute( 'image' ) href=false() css_class=false() image_css_class="img-responsive"}
                </a>
            {/if}
            {*
            <p>
                <button type="button" class="btn btn-default btn btn-block btn-magenta text-uppercase margin-top-5">Prenotalo ora</button>
            </p>
            *}
        </div>
        <div class="col-sm-8">
            <article>
                <header>
                    <a href="{$item.url_alias|ezurl('no')}"><h3>{$item.name|wash()}</h3></a>
                    <p>
                        <a href="{concat($item.parent.url_alias|ezurl(no), '/(attribute', $item.data_map.autori.contentclassattribute_id, ')/', $item.object.data_map.autori.content, '/(class_id)/', $item.object.contentclass_id)}">{attribute_view_gui attribute=$item|attribute( 'autori' )}</a>
                        {if $item|has_attribute( 'traduttore' )}
                            (traduttore {attribute_view_gui attribute=$item|attribute( 'traduttore' )})
                        {/if}<br>
                        <a href="{concat($item.parent.url_alias|ezurl(no), '/(attribute', $item.data_map.editore.contentclassattribute_id, ')/', $item.object.data_map.editore.content, '/(class_id)/', $item.object.contentclass_id)}">{attribute_view_gui attribute=$item|attribute( 'editore' )}</a>
                    </p>
                </header>
                <div class="text">
                    {attribute_view_gui attribute=$item|attribute( 'descrizione' )}
                </div>
                <footer>
                    {include uri=concat('design:parts/target.tpl')
                     item=$item}
                    <p class="ellipsis">
                        <a href="{concat($item.parent.url_alias|ezurl(no), '/(attribute', $item.data_map.tipologia.contentclassattribute_id, ')/', $item.object.data_map.tipologia.class_content.options[$item.object.data_map.tipologia.data_text].name, '/(class_id)/', $item.object.contentclass_id)}" class="category initialism">{attribute_view_gui attribute=$item|attribute( 'tipologia' )}</a>
                    </p>
                </footer>
                <div class="clearfix">
                    {include uri='design:parts/social_buttons.tpl'}
                </div>
            </article>
        </div>
    </div>
</li><!-- /.col-md-6 -->
