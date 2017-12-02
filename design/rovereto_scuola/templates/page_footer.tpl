{* Chiusura del div.container *}
</div>

{def $home = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}

{def $show_logo = cond( and( is_set( $home.data_map.show_search ), $home.data_map.show_search.data_int|eq(1) ), true(), false() )
   $show_footer = cond( and( is_set( $home.data_map.footer ), $home.data_map.footer.has_content ), true(), false() )}

{if or( $show_footer, $show_logo )}
<div id="footer">
<div id="footer-contact" class="container">
      <div class="row">

          {if $show_footer}
          <div class="col-md-{if $show_logo}6{else}12{/if}">
              {attribute_view_gui attribute=$home.data_map.footer}
          </div>
          {/if}

          {if $show_logo}
          <div class="col-md-6 {if $show_footer|not()}col-md-offset-6{/if}">
              <h1 id="logo" class="pull-right">
                <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">
                    <img src="{'comune/stemma.jpg'|ezimage(no)}" alt="Stemma {ezini('SiteSettings','SiteName')}"/>
                    <span class="sitename">
                        <span class="main">{ezini('SiteSettings','SiteName')}</span>
                        <span class="detail">Provincia di Trento</span>
                    </span>
                </a>
            </h1>
          </div>
          {/if}
      </div>
  </div>
</div>
{/if}
  
