<div class="col-md-5">
  <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="m_left_20">
      {if openpacontext().logo.url}
          <img src={openpacontext().logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
    {else}
      <small>{ezini('SiteSettings','SiteName')}</small>
    {/if}
  </a>
</div>