{ezpagedata_set( 'has_container', true() )}
{def $css_page = 'col-xs-12 col-md-12 col-lg-12'}

<div id="main-container" class="layout-page">

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="{$css_page} column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'abstract' )}</div>
                    </header>

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'description' )}
                    </div>


                </div><!-- /.column-content -->
            </div>

            <ul class="row list-unstyled list-boxed">
                {foreach $node.children as $key => $value}
                    <li class="col-sm-12 item">
                        {node_view_gui view='line' content_node=$value}
                    </li>
                    {delimiter}<li class="col-sm-12 item"><hr class="dark-spacer"></li>{/delimiter}
                {/foreach}
            </ul>

        </div>
    </section><!-- /.events -->


    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
