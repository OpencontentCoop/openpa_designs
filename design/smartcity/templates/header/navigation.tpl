<div class="navbar yamm">
    <div class="container">
        <div class="row">
            <div class="navbar-header col-md-3">
                {if $pagedata.is_login_page|not()}
                    <button type="button" data-toggle="collapse" data-target="#main-menu" class="navbar-toggle"><span class="glyphicon glyphicon-menu-hamburger"></span></button>
                {/if}
                <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="navbar-brand">
                    {if $pagedata.header.logo.url}
                        <img class="hidden-xs navbar-logo" src={$pagedata.header.logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
                    {/if}
                    <span class="navbar-title hidden-sm hidden-md hidden-lg">{ezini('SiteSettings','SiteName')}</span>
                </a>
            </div>
            <div class="menu-container col-md-9">
                <div id="partners">
                    <img src="{'partners.jpg'|ezimage(no))}" class="img-responsive hidden-xs" >
                </div>
                {if $pagedata.is_login_page|not()}
                    <div id="main-menu" class="navbar-collapse collapse">
                        {include uri='design:menu/top_menu.tpl'}
                    </div>
                {/if}
            </div>
        </div>
    </div>
</div>