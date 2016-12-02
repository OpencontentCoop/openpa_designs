{* Image - Full view *}
{* Article - Full view *}

<div id="main-container" class="layout-page">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12 column-content">

                    <header>
                        <h2>{$node.name|wash()}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'sottotitolo' )}</div>
                    </header>

                    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' ) image_css_class='img_resize'}

                    {if $node|has_attribute( 'caption' )}
                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'caption' )}
                    </div>
                    {/if}


                </div><!-- /.column-content -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
