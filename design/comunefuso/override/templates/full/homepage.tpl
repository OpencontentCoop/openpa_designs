{def $extra_info = 'extra_info'
     $left_menu = ezini('SelectedMenu', 'LeftMenu', 'menu.ini')
     $openpa = object_handler($node)
     $homepage = fetch('openpa', 'homepage')
     $current_user = fetch('user', 'current_user')
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
{include uri='design:parts/openpa/wrap_full_open.tpl'}

<div class="content-view-full">
    <div class="class-frontpage">

    <div class="content-columns float-break">
	    
	    {def $opendata = false()}
	    {def $opendata_object = fetch(content, object, hash(remote_id, opendata_area))}
	    {if $opendata_object}
	    	{set $opendata = $opendata_object.main_node}
	    {/if}
	    
	    {def $trasparenza = false()}
	    {def $sezione_trasparenza = fetch('content','tree',hash( parent_node_id,1,class_filter_type,'include',class_filter_array,array(trasparenza),limit,1))}
		{if is_set($sezione_trasparenza[0])}
			{set $trasparenza = $sezione_trasparenza[0]}
		{/if}

		{if $trasparenza}		
			{block_view_gui block=fake_block('Singolo', 'singolo_box', array($trasparenza))}
		{/if}

		{if $opendata}		
			{block_view_gui block=fake_block('Singolo', 'singolo_box', array($opendata))}
		{/if}		

    </div>

    </div>
</div>

{include uri='design:parts/openpa/wrap_full_close.tpl'}