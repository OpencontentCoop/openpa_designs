{ezpagedata_set( 'has_container', true() )}
{def $css_page = 'col-xs-12 col-md-12 col-lg-12'}
{if $node|has_attribute( 'image' )}
    {set $css_page = 'col-xs-12 col-md-9 col-lg-9'}
{/if}
{def $openpa = object_handler($node)}

<div id="main-container" class="layout-page">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="{$css_page} column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>                        
                    </header>

                    <div class="text">
                        {include uri=$openpa.content_main.template}
                    </div>

                     {include uri=$openpa.content_detail.template}

                </div><!-- /.column-content -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>