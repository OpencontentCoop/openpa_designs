{ezpagedata_set( 'has_container', true() )}
{def $css_page = 'col-xs-12 col-md-12 col-lg-12'}
{if $node|has_attribute( 'image' )}
    {set $css_page = 'col-xs-12 col-md-9 col-lg-9'}
{/if}


<div id="main-container" class="layout-page">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="{$css_page} column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <div class="lead">
                            {attribute_view_gui attribute=$node|attribute( 'crono' )}
                            {if $node|has_attribute( 'consistenza' )}
                                ({attribute_view_gui attribute=$node|attribute( 'segnatura_cons' )})
                            {/if}
                        </div>
                    </header>

                    {if $node|has_attribute( 'consistenza' )}
                        <div class="text">
                            <h3>{$node.data_map.consistenza.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'consistenza' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'acquisizione' )}
                        <div class="text">
                            <h3>{$node.data_map.acquisizione.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'acquisizione' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'contenuto' )}
                        <div class="text">
                            <h3>{$node.data_map.contenuto.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'contenuto' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'ordinamento' )}
                        <div class="text">
                            <h3>{$node.data_map.ordinamento.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'ordinamento' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'consultabilita' )}
                        <div class="text">
                            <h3>{$node.data_map.consultabilita.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'consultabilita' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'strumento' )}
                        <h3>{$node.data_map.strumento.contentclass_attribute_name}</h3>
                        {attribute_view_gui attribute=$node|attribute( 'strumento' )}
                    {/if}

                    {if $node|has_attribute( 'bibliografia' )}
                        <div class="text">
                            <h3>{$node.data_map.bibliografia.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'bibliografia' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'soggetto_produttore' )}
                        <h3>{$node.data_map.soggetto_produttore.contentclass_attribute_name}</h3>
                        {attribute_view_gui attribute=$node|attribute( 'soggetto_produttore' )}
                    {/if}

                    {if $node|has_attribute( 'strumenti' )}
                        <h3>{$node.data_map.strumenti.contentclass_attribute_name}</h3>
                        {attribute_view_gui attribute=$node|attribute( 'strumenti' )}
                    {/if}

                </div><!-- /.column-content -->

                {if $node|has_attribute( 'image' )}
                    <aside class="col-xs-12 col-md-3 col-lg-3 column-sidebar sidebar-extra">
                        <figure class="thumbnail">
                            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() use_html5_tag=true() image_class='event_line'  css_class=false() image_css_class="img-responsive"}
                        </figure>
                    </aside><!-- /.sidebar-extra -->
                {/if}
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
