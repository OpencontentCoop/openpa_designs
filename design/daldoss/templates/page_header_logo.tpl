<a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="navbar-brand">
  {if $pagedata.header.logo.url}
    <img class="hidden-xs navbar-logo" src={$pagedata.header.logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
  {/if}
  <span class="navbar-title hidden-sm hidden-md hidden-lg">{ezini('SiteSettings','SiteName')}</span>
</a>
