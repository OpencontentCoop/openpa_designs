{if $node.data_map.image.content[$image_class]}
    {def $image = $node.data_map.image.content[$image_class]}
    <img src={$image.url|ezroot} alt="{$node.name|wash}" class="img-responsive" />
    {undef $image}
{/if}
{def $url = $node.url_alias|ezurl(no)}
{if $node|has_attribute( 'link' )}
    {set $url = concat( 'content/view/full/', $node|attribute( 'link' ).content.relation_list[0].node_id )|ezurl(no)}
{elseif $node|has_attribute( 'url' )}
    {set $url = $node|attribute( 'url' ).content}
{elseif is_set($node.data_map.link)}
    {set $url = '#'}
{/if}
<div class="container">
    <div class="carousel-caption">
        <h1 class="inverse">
            <a href="{$url}">{$node.name|wash()}</a>
        </h1>
        {if $node.data_map.image_map.has_content}
            <br class="hidden-xs">
            <p class="inverse second-line hidden-xs">{attribute_view_gui attribute=$node.data_map.image_map}</p>
        {/if}
    </div>
</div>
