{*
	GALLERIA FOTOGRAFICA
	con effetto carosello

	node	nodo della galleria
	titolo  titolo da dare al blocco (opzionale)
*}

{def $is_flip = false()}
{foreach $node.data_map as $attribute}
{if and( $attribute.data_type_string|eq( 'ezbinaryfile' ), flip_exists( $attribute.contentobject_id, $attribute.version ) )}
    {set $is_flip = true()}
    {break}
{/if}
{/foreach}

{if $is_flip|not()}

{if is_set($scope)|not() }
{def $scope = false()}
{/if}

{if $scope|eq('attribute')}
    {def $banner_folder= array($node)}
{else}
    {def $banner_folder=fetch( 'content', 'list',  hash( 'parent_node_id', $node.node_id,
														 'class_filter_type', 'include',
														 'class_filter_array', array('image', 'flash_player', 'ezflowmedia'),
														 'sort_by', $node.sort_array,
														 'limit', 30 ) )}
    {if count($banner_folder)|eq(0)}
        {set $banner_folder=fetch( 'content', 'list',  hash( 'parent_node_id', $node.object.main_node_id,
															 'class_filter_type', 'include',
															 'class_filter_array', array('image', 'flash_player', 'ezflowmedia'),
															 'sort_by', $node.object.main_node.sort_array,
															 'limit', 30 ) )}
    {/if}
{/if}

{if count($banner_folder)|gt(0)}

<div class="banner-carousel photogallery float-break">

{if $node.object.class_identifier|eq('gallery')}
	<h3><a href={$node.object.main_node.url_alias|ezurl()}>{$node.name|wash()}</a></h3>
{elseif $scope|eq('attribute')}
	<h3>{$titolo}</h3> 	
{else}
	<h3>Immagini riferite a "{$node.name|wash()}"</h3>
{/if}

{include name = attributi_principali uri = 'design:parts/gallery.tpl' nodes = $banner_folder image_class=squarethumb}


</div>
{/if}
{/if}

{undef $is_flip}
