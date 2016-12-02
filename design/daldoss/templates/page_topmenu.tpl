{def $extra_item = cond( is_set( fetch( openpa, homepage ).data_map.menu_button ), fetch( openpa, homepage ).data_map.menu_button.content, false() )}

<div class="container">
  <div id="navigation" class="menu_wrap">
      {include uri=concat('design:menu/top_menu.tpl')}
  </div>
</div>

{include uri=concat('design:menu/topmenu_extra_modal.tpl')}
