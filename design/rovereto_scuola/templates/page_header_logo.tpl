<div class="row">
    <div class="col-md-6">
        <h1 id="logo_area_tematica">            
            {if and( is_set( $home.data_map.logo ), $home.data_map.logo.has_content )}
                {attribute_view_gui attribute=$home.data_map.logo image_class=large href=$home.url_alias|ezurl()}
            {else}
            <a href={$home.url_alias|ezurl} title="{$home.name|wash()}">                
                {$home.name|wash()}
            </a>
            {/if}
        </h1>
    </div>
    <div class="col-md-6">
        <div class="row">            
            {if $pagedata.top_menu}
            <div class="col-xs-3">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Mostra menu</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            {/if}
            <div class="col-xs-9">
              {if and( is_set( $home.data_map.show_search ), $home.data_map.show_search.data_int|eq(1) )}
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
                    
                        {if $home}
                            <input type="hidden" value="{$home.node_id}" name="SubTreeArray[]" />
                        {/if}
                        <input type="hidden" value="Cerca" name="SearchButton" />                    
                    </fieldset>
                </form>			  
			  {else}
                <h1 id="logo" class="pull-right">
                    <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">
                        <img src="{'comune/stemma.jpg'|ezimage(no)}" alt="Stemma {ezini('SiteSettings','SiteName')}"/>
                        <span class="sitename">
                            <span class="main">{ezini('SiteSettings','SiteName')}</span>
                            <span class="detail">Provincia di Trento</span>
                        </span>
                    </a>            
                </h1>
			  {/if}                
            </div>
        </div>
    </div>
</div>
