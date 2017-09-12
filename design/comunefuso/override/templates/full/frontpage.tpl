{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

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