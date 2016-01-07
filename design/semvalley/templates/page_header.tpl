<div id="header" role="banner">

  {if $pagedata.is_login_page|not()}
  <section class="header-top">
    <div class="container">
        <div class="row clearfix">
          {include uri='design:header/tools.tpl'}
          {include uri='design:header/user_login.tpl'}
          {include uri='design:header/links.tpl'}
        </div>
    </div>
  </section>
  {/if}

  <div class="header-bottom container">
    <div class="clearfix row">
      {include uri='design:header/logo.tpl'}
    </div>
  </div>

</div>