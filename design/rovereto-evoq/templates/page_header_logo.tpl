<div class="row" {*role="brand"*}>
    <div class="col-md-7">
        <h1 id="logo">
            <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">
                <img src="{'comune/stemma.jpg'|ezimage(no)}" alt="Stemma {ezini('SiteSettings','SiteName')}"/>
                <span class="sitename">
                    <span class="main">{ezini('SiteSettings','SiteName')}</span>
                    <span class="detail">Provincia di Trento</span>
                </span>
            </a>
        </h1>
    </div>
    <div class="col-md-5">
        <div class="row">
            {if or( is_section( 'comune' ), is_section( 'citta' ) )}
            <div class="col-xs-2">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Mostra menu</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            {/if}
            <div class="col-xs-{if or( is_section( 'comune' ), is_section( 'citta' ) )}10{else}12{/if}">
                <form action={"/content/search"|ezurl} id="searchbox">
                    <fieldset>
                        <legend class="hide">Strumenti di ricerca</legend>
                        <label for="searchbox_text" class="hide">{'Search'|i18n('design/ezwebin/pagelayout')}</label>
                        {if $pagedata.is_edit}
                            <input disabled="disabled" id="searchbox_text" name="SearchText" type="text" value="" size="12" />
                            <button type="submit"><img src="{'comune/searchbutton.png'|ezimage(no)}" alt="{'Search'|i18n('design/ezwebin/pagelayout')}" /></button>
                        {else} 
                            <input id="searchbox_text" name="SearchText" type="text" />
                            <button class="btn-link" type="submit"><img src="{'comune/searchbutton.png'|ezimage(no)}" alt="{'Search'|i18n('design/ezwebin/pagelayout')}" /></button>
                            {if eq( $ui_context, 'browse' )}
                                <input name="Mode" type="hidden" value="browse" />
                            {/if}
                        {/if}
                    
                        {if is_area_tematica()}
                            <input type="hidden" value="{is_area_tematica().node_id}" name="SubTreeArray[]" />
                        {/if}
                        <input type="hidden" value="Cerca" name="SearchButton" />                    
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>