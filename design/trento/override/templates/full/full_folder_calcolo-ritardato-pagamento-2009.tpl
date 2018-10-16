{def $extra_info = 'extra_info'
     $left_menu = ezini('SelectedMenu', 'LeftMenu', 'menu.ini')
     $openpa = object_handler($node)
     $homepage = fetch('openpa', 'homepage')
     $current_user = fetch('user', 'current_user')
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
{include uri='design:parts/openpa/wrap_full_open.tpl'}
{*?template charset=utf-8?*}
<iframe src="http://www2.comune.trento.it/trento/Trento65.nsf/calcolodateE2009?openform" width="788px" height="855px">
  Problemi legati alla lettura degli i-frame... ci scusiamo per il disagio!
</iframe>
{include uri='design:parts/openpa/wrap_full_close.tpl'}