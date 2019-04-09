{ezpagedata_set( 'has_container', true() )}
{* Gallery - Full view *}

<div id="main-container" class="layout-page">

    <section class="main-content gray">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12 column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'short_description' )}</div>
                    </header>

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'description' )}
                    </div>


                </div><!-- /.column-content -->
            </div>

            {if fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                              'class_filter_type', 'include',
                                              'class_filter_array', array( 'image', 'video' ) ) )}

                {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                                 'class_filter_type', 'include',
                                                                 'class_filter_array', array( 'image', 'video' ),
                                                                 'sort_by', $node.sort_array ) )}

                {include uri='design:atoms/gallery.tpl' items=$children}
            {/if}

        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>

