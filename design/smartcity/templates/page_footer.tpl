{if and( $ui_context|ne( 'edit' ), $ui_context|ne( 'browse' ) )}
    {if and( $current_node_id|ne(2), $pagedata.class_identifier|ne('frontpage'), $pagedata.class_identifier|ne('') ) }
        <div id="valuation-container">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        {include name=valuation node_id=$current_node_id uri='design:openpa/valuation.tpl'}
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/if}

<div id="footer">
    {if and( $ui_context|ne( 'edit' ), $ui_context|ne( 'browse' ), $pagedata.is_login_page|not() )}
        <div class="footer-data container">
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-3 notes">
                    <h4>{ezini('SiteSettings','SiteName')}</h4>
                    {def $footer_notes = fetch( 'openpa', 'footer_notes' )}
                    {if $footer_notes}
                        {attribute_view_gui attribute=$footer_notes}
                    {/if}
                </div>

                {*<div class="col-lg-3 col-md-3 col-sm-3 contacts">
                    {include uri='design:footer/contacts_list.tpl'}
                </div>*}

                <div class="col-lg-4 col-md-4 col-sm-4 links">
                    <h4>Menù</h4>
                    {def $footer_links = fetch( 'openpa', 'footer_links' )}
                    {if count( $footer_links )}
                        {*<ul class="list-unstyled ">*}
                        <div class="row">
                            <div class="col-xs-6">
                                {foreach $footer_links as $item}
                                    {def $href = $item.url_alias|ezurl(no)}
                                    {if eq( $ui_context, 'browse' )}
                                        {set $href = concat("content/browse/", $item.node_id)|ezurl(no)}
                                    {elseif $pagedata.is_edit}
                                        {set $href = '#'}
                                    {elseif and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                                        {set $href = $item.data_map.location.content}
                                    {/if}
                                        <a href="{$href}" title="Leggi {$item.name|wash()}">{$item.name|wash()}</a>
                                        {delimiter}</div><div class="col-xs-6">{/delimiter}
                                    {undef $href}
                                {/foreach}
                            </div>

                        </div>
                    {/if}
                </div>

                <div class="col-lg-5 col-md-5 col-sm-5">
                    <h4>Sponsor</h4>
                </div>
            </div>
        </div>
        {if is_set($pagedata.contacts.indirizzo)}
            <div id="footer-map-container" class="" style="display: none">
                <span class="caret caret-big"></span>
                {include uri='design:footer/map.tpl'}
                {include uri='design:page_skyline.tpl'}
            </div>
        {/if}
    {/if}

</div>