{def $parent_event_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'EventTypesNodeID', 'content.ini' ) ) )
     $events_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'EventsNodeID', 'content.ini' ) ) )
     $parent_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'EventsHomeNodeID', 'content.ini' ) ) )
     $nodes=fetch('content','list',
        hash(
            'parent_node_id', $parent_node.node_id,
            'sort_by', $parent_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('event'),
            'limit', 3))}

{*set_defaults(hash(
  'show_title', true(),
  'show_link', true(),
  'number', 5,
  'view', 'line'
))}

{*def $curr_ts = currentdate()
      $curr_today = $curr_ts|datetime( custom, '%j')
      $curr_year =  $curr_ts|datetime( custom, '%Y')
      $curr_month = $curr_ts|datetime( custom, '%n')
      $today_ts = makedate( $curr_month, $curr_today, $curr_year )
      $upcoming_events = fetch( 'content', 'list',
                        hash( 'parent_node_id', $events_node.node_id,
                              'limit', 3,
                              'sort_by', array( 'attribute', true(), 'event/from_time'),
                              'main_node_only', true(),
                              'class_filter_type', 'include',
                              'class_filter_array', array( 'event' ),
                              'attribute_filter', array(
                              'or',
                              array( 'event/v', '>=', $today_ts ),
                              array( 'event/to_time', '>=', $today_ts ) ) ) )*}

<section class="events gray">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group pull-right btn-filter">
                    <button type="button" class="btn btn-default btn-block dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-calendario"></i> Calendario eventi <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        {foreach $parent_event_types.children as $c}
                            <li><a href="{$events_node.url_alias|ezurl('no')}/(Tipologia)/{$c.name}">{$c.name}</a></li>
                        {/foreach}
                    </ul>
                </div><!-- ./btn-filter -->
                <h2 class="text-center title">Eventi e attività in biblioteca</h2>
            </div>
        </div>
        <ul class="row list-unstyled list-boxed">
            {foreach $nodes as $key => $value}
                <li class="col-sm-4 item">
                    {node_view_gui view='line' content_node=$value.object.main_node}
                </li>
            {/foreach}
        </ul><!-- /.row -->
        <div class="row">
            <div class="col-sm-4 col-sm-offset-4">
                <a href="{$events_node.url_alias|ezurl('no')}" class="btn btn-default btn-lg btn-block btn-dark text-uppercase">Mostra altri eventi</a>
            </div><!-- /.col-sm-4 -->
        </div>
    </div>
</section><!-- /.events -->
