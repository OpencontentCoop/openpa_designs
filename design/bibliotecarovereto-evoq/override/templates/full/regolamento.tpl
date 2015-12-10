{def $css_page = 'col-xs-12 col-md-12 col-lg-12'
     $sidebar = false()
     $filter_tools = false()}
{if $node|has_attribute( 'image' )}
    {set $sidebar = true()
         $css_page = 'col-xs-12 col-md-9 col-lg-9'}
{/if}
{if $node.data_map.classi_filtro.has_content}
    {set $css_page = 'col-xs-12 col-md-9 col-lg-9'}
{/if}


<div id="main-container" class="layout-page">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="{$css_page} column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'abstract' )}</div>
                    </header>

                    {if $node|has_attribute( 'file' )}
                        <div class="text">
                            <h3>{$node.data_map.file.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'file' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'area' )}
                        <div class="text">
                            <h3>{$node.data_map.area.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'area' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'data_iniziopubblicazione' )}
                        <div class="text">
                            <h3>{$node.data_map.data_iniziopubblicazione.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'data_iniziopubblicazione' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'data_archiviazione' )}
                        <div class="text">
                            <h3>{$node.data_map.data_archiviazione.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'data_archiviazione' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'codice' )}
                        <div class="text">
                            <h3>{$node.data_map.codice.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'codice' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'servizio' )}
                        <div class="text">
                            <h3>{$node.data_map.servizio.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'servizio' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'argomento' )}
                        <div class="text">
                            <h3>{$node.data_map.argomento.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'argomento' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'data_inizio_validita' )}
                        <div class="text">
                            <h3>{$node.data_map.data_inizio_validita.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'data_inizio_validita' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'data_fine_validita' )}
                        <div class="text">
                            <h3>{$node.data_map.data_fine_validita.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'data_fine_validita' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'iter_approvazione' )}
                        <div class="text">
                            <h3>{$node.data_map.iter_approvazione.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'iter_approvazione' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'documento' )}
                        <div class="text">
                            <h3>{$node.data_map.documento.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'documento' )}
                        </div>
                    {/if}

                    {if $node|has_attribute( 'area_interesse' )}
                        <div class="text">
                            <h3>{$node.data_map.area_interesse.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'area_interesse' )}
                        </div>
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

{undef $css_page $sidebar $filter_tools}
