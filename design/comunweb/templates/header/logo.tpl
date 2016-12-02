<div class="col-lg-2 col-sm-12 t_md_align_c m_md_bottom_15">
  <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">
    {if $pagedata.header.logo.url}
      <img class="img-responsive center-block" src={$pagedata.header.logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
    {else}
      <small>{ezini('SiteSettings','SiteName')}</small>
    {/if}
  </a>
</div>
