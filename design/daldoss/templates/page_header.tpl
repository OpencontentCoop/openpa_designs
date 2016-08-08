<header>
  <div id="nav-container" class="container">
    <div class="row">
      <div class="col-sm-4 hidden-xs">
        {include uri='design:page_header_languages.tpl'}
        {*include uri='design:page_header_links.tpl'*}
      </div>
      <div class="col-xs-12 col-sm-8 text-right">
        {include uri='design:page_header_links.tpl'}
      </div>
    </div>

    <div class="row">
      <div class="branding col-xs-8 col-sm-8 col-md-8">
        {include uri='design:page_header_logo.tpl'}
      </div>
      <div class="col-xs-4">
        <button id="menu_button">
          <span class="centered_db "></span>
          <span class="centered_db "></span>
          <span class="centered_db "></span>
        </button>
        <div class="hidden-xs">
          {include uri='design:page_header_searchbox.tpl'}
        </div>
      </div>
      <div class="col-xs-9 hidden-sm hidden-md hidden-lg">
        {include uri='design:page_header_searchbox.tpl'}
      </div>
      <div class="col-xs-3 hidden-sm hidden-md hidden-lg">
        <a href="{'partecipa'|ezurl(no)}" class="btn btn-primary pull-right" title="Di la tua">#DILATUA</a>
      </div>
    </div>

    {*<div class="row">
      <div class="branding col-sm-4">
        {include uri='design:page_header_logo.tpl'}
      </div>
      <div class="col-sm-8">
        <div class="row">
          <div class="col-sm-8 text-right">
            {include uri='design:page_header_languages.tpl'}
          </div>
          <div class="col-sm-4">
            {include uri='design:page_header_searchbox.tpl'}
          </div>
        </div>
    </div>*}
  </div>

</header>