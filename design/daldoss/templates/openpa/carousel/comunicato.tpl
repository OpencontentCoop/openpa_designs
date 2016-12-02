<div class="relative">
{if $node|has_attribute( 'image' )}
    {def $image = $node.data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>
    {undef $image}
{elseif $node.data_map.immagini.has_content}
    {def $image_node = fetch( 'content', 'node', hash( 'node_id', $node.data_map.immagini.content.relation_list[0].node_id ) )
         $image = $image_node.data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>
    {undef $image_node $image}
{else}
  <img src={'placeholder.png'|ezimage} width="1200" height="600" alt="{$node.name|wash}" class="img-responsive mw_mxs_none mw_xs_none"/>
{/if}


<div class="carousel-caption">
    <h3>	
      <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>	
    </h3>
    <p>{$node|abstract()|oc_shorten(400)}</p>
</div>
</div>
