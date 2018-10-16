{def $extra_info = 'extra_info'
     $left_menu = ezini('SelectedMenu', 'LeftMenu', 'menu.ini')
     $openpa = object_handler($node)
     $homepage = fetch('openpa', 'homepage')
     $current_user = fetch('user', 'current_user')
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
{include uri='design:parts/openpa/wrap_full_open.tpl'}
<div class="border-box">
<div class="global-view-full content-view-full">
<div class="class-folder">

    <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
    </div>

	<div class="abstract">
		{attribute_view_gui attribute=$node.data_map.abstract}
	</div>

	{def $children_remote_folder = fetch(content,list,hash(parent_node_id,53949, sort_by, array(priority, true())))}

	{foreach  $children_remote_folder as $child}
	  {def $objects=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $child.object.id, 'attribute_identifier', '796' ) )}
	  {def $objects_count=fetch( 'content', 'reverse_related_objects_count', hash( 'object_id', $child.object.id, 'attribute_identifier', '796' ) )}
	  {def $objects2=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $child.object.id, 'attribute_identifier', '823' ) )}
	  {def $objects2_count=fetch( 'content', 'reverse_related_objects_count', hash( 'object_id', $child.object.id, 'attribute_identifier', '796' ) )}
	
		{if or($objects_count|gt(0), $objects2_count|gt(0))}
			<h2>{$child.name}</h2>
			<div class="main-image left">
				{if $child.data_map.image.has_content}
					{attribute_view_gui attribute=$child.data_map.image image_class='medium'}
				{else}
					{*<img src="/share/icons/crystal/48x48/mimetypes/{$child.name|wash()}.png" alt="{$child.name|wash()}" title="{$node.name|wash()}" />*}
					<img src={concat('icons/crystal/64x64/mimetypes/',$child.name,'.png')|ezimage()} alt="{$child.name|wash()}" title="{$child.name|wash()}" />
				{/if}
			</div>
			<p>{attribute_view_gui attribute=$child.data_map.abstract}</p>

			{if $objects_count|gt(0)}
			<ul>
				{foreach $objects as $object}
				     	<li><a href={$object.main_node.url_alias|ezurl()}>{$object.main_node.name}</a></li>
				{/foreach}
			</ul>
			<br />
			{/if}

			{if $objects2_count|gt(0)}
				{foreach $objects2 as $object}
				     	<a href={$object.main_node.url_alias|ezurl()}>{$object.main_node.name}</a><br />
				{/foreach}
			{/if}

			<div class="break"></div>
		{/if}
	{/foreach}	

</div>
</div>
</div>
{include uri='design:parts/openpa/wrap_full_close.tpl'}