{def $home = fetch( content, node, hash( node_id, ezini('NodeSettings','RootNode','content.ini') ) )
     $home_reverse_related = fetch( content, reverse_related_objects, hash( object_id, $home.contentobject_id ) )
     $images = array()}
{foreach $home_reverse_related as $related}
    {if $related.class_identifier|eq('gallery')}
        {set $images = fetch( content, list, hash( parent_node_id, $related.main_node_id ) )}
    {/if}
{/foreach}
{if count($images)|gt(0)}
    <script>
    $(document).ready(function(){ldelim}
        $("#page.home").roveretobgswitcher({ldelim}images: [{foreach $images as $image}"{$image.data_map.image.content['background'].url|ezroot(no)}"{delimiter},{/delimiter}{/foreach}]{rdelim});
    {rdelim});
    </script>
    {ezscript_require(array('jquery.roveretobgswitcher.js'))}
{/if}