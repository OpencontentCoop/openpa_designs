{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}
{def $calendar_view = first_set( $current_calendar_view, 'calendar' )}
{if is_set( $view_parameters.view )}
    {set $calendar_view = $view_parameters.view}
{/if}
{include name=calendar node=$node uri=concat("design:calendar/",$calendar_view,".tpl") view_parameters=$view_parameters }