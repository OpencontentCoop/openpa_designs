<div class="relative">
{if $node.data_map.image.content[$image_class]}
    {def $image = $node.data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>
    {undef $image}
{else}
  <img src={'placeholder.png'|ezimage} width="1200" height="800" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>    
{/if}


<div class="carousel-caption">
    <h3>
	{if $node.class_identifier|eq('banner')}
		{def $res_fetch=fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', 'banner/internal_location' ) )}
		<a href={$res_fetch[0].main_node.url_alias|ezurl()}>{$node.name|wash()}</a>
	{else}
		<a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
	{/if}
    </h3>
    {*<p>{$node|abstract()|oc_shorten(400)}</p>*}
</div>
</div>
