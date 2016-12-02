{def $target = fetch( 'content', 'node', hash( 'node_id', $view_parameters.Target ) )}

<div id="main-container" class="layout-page">

    <section class="main-content gray">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12 column-content">

                    <header>
                        <h2>{$node.name|wash} {$target.name|wash}</h2>
                        <p class="lead">{attribute_view_gui attribute=$node|attribute( 'short_name' )}</p>
                    </header>

                    <div class="text">

                        {attribute_view_gui attribute=$node|attribute( 'abstract' )}

                        <hr class="spacer">

                        {attribute_view_gui attribute=$node|attribute( 'description' )}

                    </div>
                </div><!-- /.column-content -->
            </div>

            {include uri='design:parts/inverse_related.tpl' view='line' item=$target}

        </div>
    </section><!-- /.events -->



    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
