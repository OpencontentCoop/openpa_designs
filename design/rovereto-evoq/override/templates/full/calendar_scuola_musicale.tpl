{def $extra_info = 'extra_info'
     $left_menu = ezini('SelectedMenu', 'LeftMenu', 'menu.ini')
     $openpa = object_handler($node)
     $homepage = fetch('openpa', 'homepage')
     $current_user = fetch('user', 'current_user')
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
{include uri='design:parts/openpa/wrap_full_open.tpl'}

{def $calendar_view = first_set( $current_calendar_view, 'calendar' )}
{if is_set( $view_parameters.view )}
    {set $calendar_view = $view_parameters.view}
{/if}
{include name=calendar node=$node uri=concat("design:calendar/",$calendar_view,".tpl") view_parameters=$view_parameters }

{include uri='design:parts/openpa/wrap_full_close.tpl'}