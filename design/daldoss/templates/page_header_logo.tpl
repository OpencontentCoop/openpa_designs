<a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="navbar-brand m_sm_bottom_45 t_xs_align_c">
  {if $pagedata.header.logo.url}
    <img class="navbar-logo" src={$pagedata.header.logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
  {/if}
  <span class="hidden">{ezini('SiteSettings','SiteName')}</span>
</a>
