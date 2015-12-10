{def $header_logo_background_style = fetch( 'openpa', 'header_logo_background_style' )}
<div id="logo" style="position: relative">

{def $altLogoNode = fetch( content, node, hash( node_id, 5137 ) )}
<a href={$altLogoNode.url_alias|ezurl()} title="{$altLogoNode.name|wash()}" style="position: absolute; display: block; right: 0px; width: 300px; height: 200px;">
  <span style="visibility: hidden;"></span>
</a>


{*
{if $pagedesign.data_map.image.content.is_valid|not()}
    <h1><a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">{ezini('SiteSettings','SiteName')}</a></h1>
{else}
    <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}"><img src={$pagedesign.data_map.image.content[original].full_path|ezroot} alt="{$pagedesign.data_map.image.content[original].text}" width="{$pagedesign.data_map.image.content[original].width}" height="{$pagedesign.data_map.image.content[original].height}" /></a>
{/if}
*}
<h1 style="width: 60%;{if $header_logo_background_style}margin:0{/if}"><a style="{$header_logo_background_style}" href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">{ezini('SiteSettings','SiteName')}</a></h1>
</div>