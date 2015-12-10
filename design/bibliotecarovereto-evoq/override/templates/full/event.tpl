{def $parent_event_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'EventTypesNodeID', 'content.ini' ) ) )
     $types = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id, 'all_relations', false(), 'attribute_identifier', 'event/tipo_evento' ) )
     $biblio_types = array()}

{*def
    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year =  $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')
    $today_ts = makedate( $curr_month, $curr_today, $curr_year )
    $upcoming_events = fetch( 'content', 'list',
                        hash( 'parent_node_id', $node.parent.node_id,
                              'limit', 4,
                              'sort_by', array( 'attribute', true(), 'event/from_time'),
                              'main_node_only', true(),
                              'class_filter_type', 'include',
                              'class_filter_array', array( 'event' ),
                              'attribute_filter', array(
                              'or',
                              array( 'event/from_time', '>=', $today_ts ),
                              array( 'event/to_time', '>=', $today_ts ) ) ) )*}


{foreach $types as $t}
    {if eq($t.main_parent_node_id, $parent_event_types.node_id)}
        {set $biblio_types=$biblio_types|append($t)}
    {/if}
{/foreach}


<div id="main-container" class="layout-page section-eventi-e-attivita page-evento">
    {*$node.data_map.tipo_evento.content.relation_list|attribute(show)}

    {$types|attribute(show)*}

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-push-0 col-md-6 col-md-push-3 col-lg-6 col-lg-push-2 column-content">

                    <header>
                        <h3>{$node.name|wash()}</h3>
                        {if $node.data_map.to_time.has_content}
                            {*if eq($node.data_map.from_time.content.timestamp, $node.data_map.to_time.content.timestamp)}
                                <p>{$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}, ore {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%H.%i' )}</p>*}
                            {if and(gt($node.data_map.to_time.content.timestamp, $node.data_map.from_time.content.timestamp), lt(sub($node.data_map.to_time.content.timestamp, $node.data_map.from_time.content.timestamp), 86400 ))}
                                <p>{$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )} dalle {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%H.%i' )} alle {$node.data_map.to_time.content.timestamp|datetime( 'custom', '%H.%i' )}</p>
                            {else}
                                <p>Dal {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )} al {$node.data_map.to_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}</p>
                            {/if}
                        {else}
                            <p>Dal {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}, ore {$node.data_map.from_time.content.timestamp|datetime( 'custom', '%H.%i' )}</p>
                        {/if}
                    </header>

                    <div class="text">
                        {*attribute_view_gui attribute=$node|attribute( 'abstract' )}

                        <hr class="spacer">*}

                        {attribute_view_gui attribute=$node|attribute( 'text' )}

                        {*if $node|attribute( 'informazioni' ).has_content}
                            <h4 class="text-uppercase">Ulteriori informazioni</h4>
                            {attribute_view_gui attribute=$node|attribute( 'informazioni' )}
                        {/if*}
                    </div>
                </div><!-- /.column-content -->

                <aside class="col-xs-6 col-xs-pull-0 col-md-3 col-md-pull-6 col-lg-2 col-lg-pull-6 column-sidebar sidebar-main">
                    {*
                    <h4 class="text-uppercase">Altri eventi</h4>
                    <ul class="list-unstyled list-menu">
                        {foreach $upcoming_events as $key => $value}
                            {def $_types = fetch( 'content', 'related_objects', hash( 'object_id', $value.contentobject_id, 'all_relations', false(), 'attribute_identifier', 'event/tipo_evento' ) )
                                 $_biblio_types = array()}
                            {foreach $_types as $t}
                                {if eq($t.main_parent_node_id, $parent_event_types.node_id)}
                                    {set $_biblio_types=$_biblio_types|append($t)}
                                {/if}
                            {/foreach}
                            <li>
                                <a href="{$value.url_alias|ezurl(no)}">{$value.name|wash()}</a>
                                <span class="category initialism">{$_biblio_types[0].data_map.titolo.content}</span>
                            </li>
                            {undef $_types $_biblio_types}
                        {/foreach}
                    </ul>

                    <hr class="spacer">

                    <div class="btn-group btn-filter">
                        <button type="button" class="btn btn-default btn-block dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-calendario"></i> Calendario eventi <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            {foreach $parent_event_types.children as $c}
                                <li><a href="{$node.parent.url_alias|ezurl('no')}/(Tipologia)/{$c.name}">{$c.name}</a></li>
                            {/foreach}
                        </ul>
                    </div>
                    *}

                    <h3>
                        Eventi e attività
                    </h3>

                    <hr class="spacer">

                    <a href="{$node.parent.url_alias|ezurl(no)}" class="btn btn-sm btn-block btn-magenta text-uppercase">Calendario eventi</a>

                    <hr class="spacer">

                    {foreach fetch( content, 'list', hash(
                                             'parent_node_id', $node.parent.node_id,
                                             'class_filter_type', 'exclude',
                                             'class_filter_array', array( 'event' ),
                                             'sort_by', $node.parent.sort_array
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
                        {delmiter}<hr class="spacer">{/delimiter}
                    {/foreach}

                </aside><!-- /.sidebar-main -->
                <aside class="col-xs-6 col-md-3 col-lg-4 column-sidebar sidebar-extra">

                    {if $node|has_attribute( 'image' )}
                        <figure class="thumbnail">
                            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='event_line' css_class=false() image_css_class="img-responsive"}
                        </figure>
                    {/if}

                    <hr class="spacer">

                    <a href="{concat($node.parent.url_alias|ezurl(no), '/(Tipologia)/', $biblio_types[0].data_map.titolo.content)}"><h4 class="category initialism bg-{ezini( 'TypeSettings', $biblio_types[0].id, 'content.ini' )}">{$biblio_types[0].data_map.titolo.content}</h4></a>

                    {if fetch( 'content', 'related_objects_count', hash( 'object_id', $node.contentobject_id, 'all_relations', false(), 'attribute_identifier', 'event/target' ) )}

                        <hr class="spacer">

                        <div class="well target-info">
                            <h4 class="initialism">
                                Questo evento è adatto a
                            </h4>
                            {include uri='design:parts/target.tpl' css_classes='' item=$node}
                        </div>
                    {/if}

                    <hr class="spacer">

                    {include uri='design:parts/social_buttons.tpl'
                    vertical=true()}

                </aside><!-- /.sidebar-extra -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}

</div>
