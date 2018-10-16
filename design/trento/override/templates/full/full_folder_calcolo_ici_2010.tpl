{def $extra_info = 'extra_info'
     $left_menu = ezini('SelectedMenu', 'LeftMenu', 'menu.ini')
     $openpa = object_handler($node)
     $homepage = fetch('openpa', 'homepage')
     $current_user = fetch('user', 'current_user')
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
{include uri='design:parts/openpa/wrap_full_open.tpl'}
{set scope=global persistent_variable=hash('extra_menu', false())}
<iframe class="content-iframe" src="http://www2.comune.trento.it/trento/trento65.nsf/CartE?ReadForm&Anno=2010" width="100%" height="855px" title="Calcolo ICI 2010">
  Problemi legati alla lettura degli i-frame... ci scusiamo per il disagio!
</iframe>
{include uri='design:parts/openpa/wrap_full_close.tpl'}