{ezscript_require(array( 'ezjsc::jquery' ) )}
<script type="text/javascript">
{literal}
$(function() {	    
    if (location.hash == '') {      
      $("html, body").animate({ scrollTop: $("#today").offset().top });
    }
});
{/literal}
</script>

{def $currentInterval = 'P1M'
     $calendarData = fetch( openpa, calendario_eventi, hash( 'calendar', $node, 'params', hash( 'interval', $currentInterval, 'view', 'program' )|merge( $view_parameters ) ) )}

<form class="calendar-tools" method='GET' action={concat('openpa/calendar/', $node.node_id)|ezurl}>
    <input type='hidden' name="UrlAlias" value="{$node.url_alias}" />
    <input type='hidden' name="View" value="program" />
    <input type='hidden' name="CurrentInterval" value="{$calendarData.parameters.interval}" />
    <input type="hidden" name="SearchDate" value="{$calendarData.parameters.picker_date}" />

    <div class="navigation-calendar hidden-xs pull-right">
        <div class="btn-group">
            <input type="submit" name="PrevMonthCalendarButton" class="btn btn-default" value="&laquo;" />
            <input type="submit" name="ViewCalendarButton" class="btn btn-default" value="Calendario" />
            <input type="submit" name="ViewProgramButton" class="btn btn-primary" value="Lista" />
            <input type="submit" name="NextMonthCalendarButton" class="btn btn-default " value="&raquo;" />
        </div>
    </div>    
    
    <h2 class="widget_title">{$calendarData.parameters.timestamp|datetime( custom, '%F' )|upfirst()}&nbsp;{$calendarData.parameters.timestamp|datetime( custom, '%Y' )}</h2>
    
    <hr />
    {def $col-width=6 $modulo=2}
    {foreach $calendarData.day_by_day as $calendarDay}
        {if $calendarDay.count|gt(0)}

          <div class="calendar-day-program float-break row" id="day-{$calendarDay.identifier}">

            <div class="events">
            <div class="calendar-date col-xs-4 col-sm-3 col-md-2"{if $calendarDay.is_today} id="today"{/if}>
              <span class="month">{$calendarDay.start|datetime( 'custom', '%M' )}</span>
              <span class="day">{$calendarDay.start|datetime( 'custom', '%j' )}</span>
            </div>
            </div>
            
                <!--<h3 class="widget_title">
                    {if $calendarDay.is_today}Oggi - {$calendarDay.start|l10n( 'date' )}
                    {elseif $calendarDay.is_tomorrow}Domani - {$calendarDay.start|l10n( 'date' )}
                    {elseif and( $calendarDay.is_in_week, $calendarDay.is_in_month )}{*$calendarDay.start|datetime( 'custom', '%l' )*}{$calendarDay.start|l10n( 'date' )}
                    {else}{$calendarDay.start|l10n( 'date' )}
                    {/if}
                </h3>-->
              
              <div class="calendar-date col-xs-8 col-sm-9 col-md-10">
                <div class="row panels-container">                  
                  {foreach $calendarDay.events as $event}
                    <div class="col-md-{$col-width}">
                      {node_view_gui view=panel content_node=$event.node image_class=small}
                    </div>
                    {delimiter modulo=$modulo}</div><div class="row panels-container">{/delimiter}
                  {/foreach}
                </div>
              </div>

            </div>
          <hr />
        {/if}        
    {/foreach}

    {*<div class="calendar-more">
        <input type="submit" name="AddIntervalButton" class="defaultbutton pull-right" value="Mostra altri eventi" />
    </div>*}

</form>