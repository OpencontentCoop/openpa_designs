
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
                <div class="col-xs-push-0 col-md-6 col-md-push-3 col-lg-6 col-lg-push-2 column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'abstract' )}</div>
                    </header>

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'description' )}
                    </div>

                    {if $node|has_attribute( 'gps' )}
                        {attribute_view_gui attribute=$node|attribute( 'gps' )}
                    {/if}
                </div><!-- /.column-content -->

                <aside class="col-xs-6 col-xs-pull-0 col-md-3 col-md-pull-6 col-lg-2 col-lg-pull-6 column-sidebar sidebar-main">
                    <h3>
                        Eventi e attività
                    </h3>

                    <hr class="spacer">

                    <a href="{$calendar.url_alias|ezurl(no)}" class="btn btn-sm btn-block btn-magenta text-uppercase">Calendario eventi</a>

                    <hr class="spacer">

                    {foreach fetch( content, 'list', hash(
                                             'parent_node_id', $calendar.node_id,
                                             'class_filter_type', 'exclude',
                                             'class_filter_array', array( 'event' ),
                                             'sort_by', $calendar.sort_array
                                )) as $key => $value }
                        <a href="{$value.url_alias|ezurl(no)}"><h4 class="text-uppercase">{$value.name|wash()}</h4></a>
                        <ul class="list-unstyled list-menu">
                            {foreach fetch( content, 'list', hash(
                                            'parent_node_id', $value.node_id,
                                            'limit', 3,
                                            'sort_by', $value.sort_array
                                     )) as $k => $v }
                                <li><a href="{$v.url_alias|ezurl(no)}">{$v.name|wash()}</a></li>
                            {/foreach}
                        </ul>
                        {delimiter}<hr class="spacer">{/delimiter}
                    {/foreach}
                </aside><!-- /.sidebar-main -->

                {if $node|has_attribute( 'image' )}
                    <aside class="col-xs-6 col-md-3 col-lg-4 column-sidebar sidebar-extra">
                        <figure class="thumbnail">
                            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() use_html5_tag=true() image_class='event_line'  css_class=false() image_css_class="img-responsive"}
                        </figure>
                    </aside><!-- /.sidebar-extra -->
                {/if}
            </div>
        </div>
    </section><!-- /.events -->

    <section class="gray">
        <div class="container">
            {include uri='design:parts/children/filters.tpl' view='line'}
        </div>
    </section>


    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
