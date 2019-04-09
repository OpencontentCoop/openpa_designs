{ezpagedata_set( 'has_container', true() )}
{* Link - Full view *}

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
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'abstract' )}</div>
                    </header>

                    {if $node.data_map.location.has_content}
                        <p>
                          <a href="{$node.data_map.location.content}" target="_blank">{if $node.data_map.location.data_text}{$node.data_map.location.data_text}{else}{$node.data_map.location.content}{/if}</a>
                        </p>
                    {/if}

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'description' )}
                    </div>

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
