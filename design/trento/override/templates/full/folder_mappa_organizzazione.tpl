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

	{def $children=''  $servizi_area=''}
	
       {* cerco in "servizi indipendenti - nodo 221945" *}

        {if $node.object.content_class.is_container}
		{set $children=fetch('content', 'list',hash('parent_node_id', 221945, 
						'class_filter_type', 'include', 'class_filter_array', array('servizio'), 
						'sort_by', array('priority', true()) ))}
           {foreach $children as $child }
               	<div class="servizio-top">

				<h2>{*$child.object.class_identifier*}{node_view_gui view='toolline' content_node=$child.object.main_node}</h2>

				{include node=$child title=false() icon=true no_servizi=true uri='design:parts/articolazioni_interne.tpl'}

				{set $servizi_area=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $child.contentobject_id, 'attribute_identifier', 'servizio/area', 'sort_by', array('name', true())))}
				<ul class="servizio_area">
					{foreach $servizi_area as $servizio}
						{if $servizio.id|ne($child.contentobject_id)}
							{if $servizio.section_id|eq(1)}
								<li>
									{*$servizio.main_node.object.class_identifier*}
									{node_view_gui view='toolline' content_node=$servizio.main_node}
									{include node=$servizio.main_node title=false() icon=true uri='design:parts/articolazioni_interne.tpl'}
								</li>
							{/if}
						{/if}
					{/foreach}
				</ul>


                </div>
           {/foreach}
        {/if}

		{* cerco in "aree"- nodo 240 *}


        {if $node.object.content_class.is_container}
		{set $children=fetch('content', 'list',hash('parent_node_id', 240,
						'class_filter_type', 'include', 'class_filter_array', array('servizio'), 
						'sort_by', array('priority', true())  ))}

			<div class="servizio-top">
			{foreach $children as $child }

				<h2>{*$child.object.class_identifier*}{node_view_gui view='toolline' content_node=$child}</h2>

				
				{include node=$child title=false() icon=true no_servizi=true uri='design:parts/articolazioni_interne.tpl'}

				{set $servizi_area=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $child.contentobject_id, 'attribute_identifier', 'servizio/area', 'sort_by', array('name', true())))}
				<ul class="servizio_area">
					{foreach $servizi_area as $servizio}
						{if $servizio.id|ne($child.contentobject_id)}
							{if $servizio.section_id|eq(1)}
								<li>
									{*$servizio.main_node.object.class_identifier*}
									{node_view_gui view='toolline' content_node=$servizio.main_node}
									{include node=$servizio.main_node title=false() icon=true uri='design:parts/articolazioni_interne.tpl'}
								</li>
							{/if}
						{/if}
					{/foreach}
				</ul>

			{/foreach}		
			</div>
		{/if}

	</div>
</div>
</div>
{include uri='design:parts/openpa/wrap_full_close.tpl'}