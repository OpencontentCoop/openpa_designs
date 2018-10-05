{ezpagedata_set( 'has_container', true() )}
{def $css_page = 'col-xs-12 col-md-12 col-lg-12'
     $sidebar = false()
     $filter_tools = false()}

<div id="main-container" class="layout-page">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="{$css_page} column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'description' )}</div>
                    </header>

                    {if $node|has_attribute( 'file' )}
                        <div class="text">
                            <h3>{$node.data_map.file.contentclass_attribute_name}</h3>
                            {attribute_view_gui attribute=$node|attribute( 'file' )}
                        </div>
                    {/if}
                </div><!-- /.column-content -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>

{undef $css_page $sidebar $filter_tools}
