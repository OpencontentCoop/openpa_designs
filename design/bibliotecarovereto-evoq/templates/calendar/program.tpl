{* workaround caratttere + *}
{if and( is_set($view_parameters.Target), $view_parameters.Target|begins_with( 'Adulti' ) )}
  {set $view_parameters = $view_parameters|merge( hash( 'Target', 'Adulti +18') )}
{/if}
{def $currentInterval = 'P1M'
     $calendarData = fetch( openpa, calendario_eventi, hash( 'calendar', $node,
                                                             'main_node_only', true(),
                                                             'sort_by', hash( solr_field('from_time','date'), 'asc' ),
                                                             'params', $view_parameters|merge( hash( 'interval', 'P1M', 'view', 'calendar', 'sort_by', hash( solr_field('from_time','date'), 'asc' ) ) ) ) )
     $parent_event_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'EventTypesNodeID', 'content.ini' ) ) )
     $parent_target_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'TargetTypesNodeID', 'content.ini' ) ) )
     $laboratori_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'LaboratoriNode', 'content.ini' ) ) )
     $didattica_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'DidatticaNode', 'content.ini' ) ) )
     $counter = 1
     $is_search = false()}

{debug-log var=$calendarData msg='Fecth eventi'}
{*$calendarData.parameters|attribute(show)*}
{*debug-log var=$calendarData.fetch_parameters msg='Fecth eventi'*}
{*TODO: Calcolare anno primo evento presente*}
{def $start_year = 2012
     $end_year = $calendarData.parameters.current_year|sum(1)
     $months = hash(
        1, 'GEN',
        2, 'FEB',
        3, 'MAR',
        4, 'APR',
        5, 'MAG',
        6, 'GIU',
        7, 'LUG',
        8, 'AGO',
        9, 'SET',
        10, 'OTT',
        11, 'NOV',
        12, 'DIC'
    )}

<form class="calendar-tools" method='GET' action={concat('calendar/view/', $node.node_id)|ezurl}>
<input type='hidden' name="UrlAlias" value="{$node.url_alias}" />
<input type='hidden' name="View" value="program" />
<input type='hidden' name="CurrentInterval" value="{$calendarData.parameters.interval|wash()}" />
<input type="hidden" name="SearchDate" value="{$calendarData.parameters.picker_date|wash()}" />

{*
<div class="navigation-calendar hidden-xs pull-right">
<div class="btn-group">
  <input type="submit" name="PrevMonthCalendarButton" class="btn btn-default" value="&laquo;" />
  <input type="submit" name="ViewCalendarButton" class="btn btn-default" value="Calendario" />
  <input type="submit" name="ViewProgramButton" class="btn btn-primary" value="Lista" />
  <input type="submit" name="NextMonthCalendarButton" class="btn btn-default " value="&raquo;" />
</div>
</div>

<h2>{$calendarData.parameters.timestamp|datetime( custom, '%F' )|upfirst()}&nbsp;{$temp_year}</h2>



<div class="calendar-more">
    <input type="submit" name="AddIntervalButton" class="defaultbutton" value="Mostra altri eventi" />
</div>
*}


<section class="main-content gray">
        <div class="container">
            <div class="row">
                <div class="col-xs-push-0 col-md-6 col-md-push-3 col-lg-8 col-lg-push-2 column-content">
                    <div class="row">
                        <div class="col-md-12">
                            <h2 class="text-center title">Calendario eventi</h2>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 text-center">
                            <ul class="list-inline list-date">
                                {foreach $months as $key => $value}
                                    <li{if eq($key, $calendarData.parameters.month)} class="active"{/if}>
                                        <a href="{$node.url_alias|ezurl(no)}/(view)/program/(day)/1/(month)/{$key}/(year)/{$calendarData.parameters.year}/(Tipologia)/{$calendarData.parameters.Tipologia}/(Target)/{$calendarData.parameters.Target}">{$value}</a>
                                    </li>
                                {/foreach}
                            </ul>

                            <ul class="list-inline list-date">
                                {for $start_year to $end_year as $y}
                                    <li{if eq($y, $calendarData.parameters.year)} class="active"{/if}>
                                        <a href="{$node.url_alias|ezurl(no)}/(view)/program/(day)/1/(month)/{$calendarData.parameters.month}/(year)/{$y}/(Tipologia)/{$calendarData.parameters.Tipologia}/(Target)/{$calendarData.parameters.Target}">{$y}</a>
                                    </li>
                                {/for}
                            </ul>
                        </div>
                    </div>

                    <hr class="spacer">

                    <ul class="row list-unstyled list-boxed">
                        {*foreach $calendarData.day_by_day as $calendarDay}
                            {if $calendarDay.count|gt(0)}

                                {foreach $calendarDay.events as $event}
                                    <li class="col-sm-6 item">
                                        {node_view_gui content_node=$event.node view=line}
                                    </li>
                                    {if eq($counter|mod(2), 0)}
                                        <li class="col-md-12 spacer"></li>
                                    {/if}
                                    {set $counter = $counter|sum(1) }
                                {/foreach}

                            {/if}
                        {/foreach*}
                        {foreach $calendarData.events as $event}
                            <li class="col-sm-6 item">
                                {node_view_gui content_node=$event.node view=line}
                            </li>
                            {if eq($counter|mod(2), 0)}
                                <li class="col-md-12 spacer"></li>
                            {/if}
                            {set $counter = $counter|sum(1) }
                        {/foreach}
                    </ul><!-- /.row -->
                </div><!-- /.column-content -->
                <aside class="col-xs-6 col-xs-pull-0 col-md-3 col-md-pull-6 col-lg-2 col-lg-pull-8 sidebar sidebar-main">
                    <h3>
                        Eventi e attività
                    </h3>

                    <hr class="spacer">

                    <a href="{$node.url_alias|ezurl(no)}" class="btn btn-sm btn-block btn-magenta text-uppercase">Calendario eventi</a>

                    <hr class="spacer">

                    {foreach fetch( content, 'list', hash(
                                             'parent_node_id', $node.node_id,
                                             'class_filter_type', 'exclude',
                                             'class_filter_array', array( 'event' ),
                                             'sort_by', $node.sort_array
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
                <aside class="col-xs-6 col-md-3 col-lg-2 sidebar sidebar-extra">
                    <div class="well well-dark">
                        <h3>
                            Filtro eventi
                        </h3>

                        <hr class="spacer">

                        <h4 class="text-uppercase">
                            Tipologia
                        </h4>

                        <ul class="list-unstyled list-filters">
                            {foreach $parent_event_types.children as $c}
                                {if eq($c.name, $calendarData.parameters.Tipologia)}
                                    {set $is_search = true()}
                                    <li class="active">
                                        <a href="{$node.url_alias|ezurl(no)}/(view)/program/(day)/1/(month)/{$calendarData.parameters.month}/(year)/{$calendarData.parameters.year}/(Target)/{$calendarData.parameters.Target}">
                                            <i class="glyphicon glyphicon-stop {ezini( 'TypeSettings', $c.contentobject_id, 'content.ini' )}" aria-hidden="true"></i>{$c.name}
                                        </a>
                                    </li>
                                {else}
                                    <li>
                                        <a href="{$node.url_alias|ezurl(no)}/(view)/program/(day)/1/(month)/{$calendarData.parameters.month}/(year)/{$calendarData.parameters.year}/(Tipologia)/{$c.name}/(Target)/{$calendarData.parameters.Target}">
                                            <i class="glyphicon glyphicon-stop {ezini( 'TypeSettings', $c.contentobject_id, 'content.ini' )}" aria-hidden="true"></i>{$c.name}
                                        </a>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>

                        <hr class="spacer">

                        <h4 class="text-uppercase">
                            Adatto a
                        </h4>

                        <ul class="list-inline list-filters">
                            {foreach $parent_target_types.children as $t}
                                {if eq($t.name, $calendarData.parameters.Target)}
                                    {set $is_search = true()}
                                    <li class="active">
                                        <a href="{$node.url_alias|ezurl(no)}/(view)/program/(day)/1/(month)/{$calendarData.parameters.month}/(year)/{$calendarData.parameters.year}/(Tipologia)/{$calendarData.parameters.Tipologia}">
                                            <i class="icon {ezini( 'TargetSettings', $t.contentobject_id, 'content.ini' )}"></i>
                                        </a>
                                    </li>
                                {else}
                                    <li>
                                        <a href="{$node.url_alias|ezurl(no)}/(view)/program/(day)/1/(month)/{$calendarData.parameters.month}/(year)/{$calendarData.parameters.year}/(Tipologia)/{$calendarData.parameters.Tipologia}/(Target)/{$t.name}">
                                            <i class="icon {ezini( 'TargetSettings', $t.contentobject_id, 'content.ini' )}"></i>
                                        </a>
                                    </li>
                                {/if}
                            {/foreach}
                            {*<li class="active"><a href="#"><i class="icon icon-target-adulti"></i></a></li>*}
                        </ul>

                        {if $is_search}
                            <hr class="spacer">
                            <a href="{$node.url_alias|ezurl(no)}" class="btn btn-default">Azzera filtri</a>
                        {/if}

                    </div>
                </aside><!-- /.sidebar-extra -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</form>
