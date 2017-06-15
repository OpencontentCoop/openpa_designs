<div class="col-lg-8 col-md-10 clearfix t_sm_align_c m_top_10" id="navigation">
  {if $pagedata.is_login_page|not()}
  <div class="clearfix t_sm_align_l f_left f_sm_none relative s_form_wrap m_sm_bottom_15 p_xs_hr_0 m_xs_bottom_5">
    <!--button for responsive menu-->
    <button id="menu_button" class="r_corners centered_db d_none tr_all_hover d_xs_block m_xs_bottom_5">
      <span class="centered_db r_corners"></span>
      <span class="centered_db r_corners"></span>
      <span class="centered_db r_corners"></span>
    </button>
    <!--main menu-->
    {include uri=concat('design:menu/top_menu.tpl')}
  </div>
  {/if}
</div>