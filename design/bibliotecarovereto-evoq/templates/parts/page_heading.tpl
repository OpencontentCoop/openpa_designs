
<section class="heading">
    <div class="container">
        <div class="row">
            <div class="col-sm-4 col-md-5 col-lg-4 text-center-xs">
                <ul class="list-inline">
                    <li{if $pagedata.path_id_array|contains($calendar.node_id)} class="active"{/if}>
                        <a href="{$calendar.url_alias|ezurl(no)}" class="text-uppercase">Eventi e attività</a>
                        <span class="caret caret-big"></span>
                    </li>
                    <li{if $pagedata.path_id_array|contains($patrimonio.node_id)} class="active"{/if}>
                        <a href="{$patrimonio.url_alias|ezurl(no)}" class="text-uppercase">Patrimonio e risorse</a>
                        <span class="caret caret-big"></span>
                    </li>
                </ul>
            </div>
            <div class="col-sm-4 col-md-3 col-lg-4 text-center-xs">
                <a href="{'/'|ezurl( 'no' )}" title="{ezini('SiteSettings','SiteName')|wash}" class="logo">
                    <img src="{'logo-biblioteca-rovereto.png'|ezimage( 'no' )}" class="logo img-responsive">
                </a>
            </div>
            <div class="col-sm-4 col-md-4 col-lg-4 text-center-xs">
                {include uri='design:page_header_searchbox.tpl'}
            </div>
        </div>
    </div>
</section><!-- ./heading -->
