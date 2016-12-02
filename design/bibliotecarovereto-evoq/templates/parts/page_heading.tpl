
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

{*def $root_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}

<section class="intro breadcrumb-only">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ol class="breadcrumb">
                    {foreach $node.path as $p offset 1}
                        {if eq($p.node_id, $root_node.node_id)}
                            <li><a href="{$p.url_alias|ezurl(no)}">Home page</a></li>
                        {else}
                            <li><a href="{$p.url_alias|ezurl(no)}">{$p.name|wash}</a></li>
                        {/if}
                    {/foreach}
                    <li class="active">{$node.name|wash}</li>
                </ol>
            </div>
        </div>
    </div>
</section>
*}
