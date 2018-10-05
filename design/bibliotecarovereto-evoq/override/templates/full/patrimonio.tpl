{ezpagedata_set( 'has_container', true() )}
{def $counter = 1}

<div id="main-container" class="layout-page section-patrimonio-e-risorse page-patrimonio-e-risorse">

    <section class="intro">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 title">
                    <h1>Patrimonio e risorse</h1>
                </div>
                <div class="col-sm-6 description">
                    <div class="lead">
                        {attribute_view_gui attribute=$node|attribute( 'abstract' )}
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="main-content gray">
        <div class="container">
            <div class="row">
                <div class="col-md-12 column-content">
                    <ul class="row list-unstyled list-boxed">
                        {foreach $node.children as $key => $value}
                        <li class="col-sm-4 item">
                            {node_view_gui view='line' content_node=$value}
                        </li>
                        {if eq($counter|mod(3), 0)}
                            <li class="col-md-12 spacer"></li>
                        {/if}
                        {set $counter = $counter|sum(1) }
                        {/foreach}
                    </ul><!-- /.row -->
                </div><!-- /.column-content -->
            </div>
        </div>
    </section><!-- /.main-content -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
