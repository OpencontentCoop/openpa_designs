<div class="col-md-5">
  <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="m_left_20">
    {if $pagedata.header.logo.url}
      <img src={$pagedata.header.logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
    {else}
      <small>{ezini('SiteSettings','SiteName')}</small>
    {/if}
  </a>
</div>