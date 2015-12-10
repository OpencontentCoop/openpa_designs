{ezpagedata_set( 'extra_menu', false() )}
{ezpagedata_set( 'left_menu', false() )}

<div class="border-box">
<div class="global-view-full content-view-full">
    <div class="class-folder">

        <h1>{attribute_view_gui attribute=$node.data_map.name}</h1>
	
        {* DATA e ULTIMAMODIFICA *}
        {include name = last_modified
                 node = $node             
                 uri = 'design:parts/openpa/last_modified.tpl'}
    
        {* EDITOR TOOLS *}
        {include name = editor_tools
                 node = $node             
                 uri = 'design:parts/openpa/editor_tools.tpl'}
    
        {* ATTRIBUTI : mostra i contenuti del nodo *}
        {include name = attributi_principali
                 uri = 'design:parts/openpa/attributi_principali.tpl'
                 node = $node}    
        
        
        {def $max = floor( $node.children_count|div(3) )}
        
        {foreach $node.children as $child}
        {/foreach}
        
                
        <div class="columns-three">
            <div class="col-1-2">
            <div class="col-1">
            <div class="col-content">
        
                {foreach $node.children as $item max $max}
                
<div class="block-type-singolo block-singolo_box">

<div class="border-box box-gray box-singolo">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">
<div class="border-content">

	<div class="attribute-header">
		{if $item.class_identifier|eq('link')}
        	<h2>
				<a href={$item.data_map.location.content|ezurl()} target="_blank" title="Apri il link '{$item.name|wash()}' in una pagina esterna (si lascerà il sito)">
					{$item.name|wash()}
				</a>
			</h2>
		{else}
        	<h2><a href="{$item.url_alias|ezurl(no)}">{$item.name}</a></h2>
		{/if}
        </div>

	{if $item.data_map.image.has_content}
    		<div class="object-center text-center">

			{if $item.class_identifier|eq('link')}
 				<a href={$item.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">
					{attribute_view_gui attribute=$item.data_map.image image_class='mainstory3'}
				</a>
			{else}
				<a href={$item.url_alias|ezurl()}>
					{attribute_view_gui attribute=$item.data_map.image image_class='mainstory3'}
				</a>
			{/if}

		</div>

	{/if}

</div>
</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

</div>
                {/foreach}
        
            </div>
            </div>
            <div class="col-2">
            <div class="col-content">
        
                {foreach $node.children as $item offset $max max $max}

<div class="block-type-singolo block-singolo_box">

<div class="border-box box-gray box-singolo">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">
<div class="border-content">

	<div class="attribute-header">
		{if $item.class_identifier|eq('link')}
        	<h2>
				<a href={$item.data_map.location.content|ezurl()} target="_blank" title="Apri il link '{$item.name|wash()}' in una pagina esterna (si lascerà il sito)">
					{$item.name|wash()}
				</a>
			</h2>
		{else}
        	<h2><a href="{$item.url_alias|ezurl(no)}">{$item.name}</a></h2>
		{/if}
        </div>

	{if $item.data_map.image.has_content}
    		<div class="object-center text-center">

			{if $item.class_identifier|eq('link')}
 				<a href={$item.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">
					{attribute_view_gui attribute=$item.data_map.image image_class='mainstory3'}
				</a>
			{else}
				<a href={$item.url_alias|ezurl()}>
					{attribute_view_gui attribute=$item.data_map.image image_class='mainstory3'}
				</a>
			{/if}

		</div>

	{/if}

</div>
</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

</div>
                {/foreach}
        
            </div>
            </div>
            </div>
            <div class="col-3">
            <div class="col-content">
        
                {foreach $node.children as $item offset $max|mul(2)}

<div class="block-type-singolo block-singolo_box">

<div class="border-box box-gray box-singolo">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">
<div class="border-content">

	<div class="attribute-header">
		{if $item.class_identifier|eq('link')}
        	<h2>
				<a href={$item.data_map.location.content|ezurl()} target="_blank" title="Apri il link '{$item.name|wash()}' in una pagina esterna (si lascerà il sito)">
					{$item.name|wash()}
				</a>
			</h2>
		{else}
        	<h2><a href="{$item.url_alias|ezurl(no)}">{$item.name}</a></h2>
		{/if}
        </div>

	{if $item.data_map.image.has_content}
    		<div class="object-center text-center">

			{if $item.class_identifier|eq('link')}
 				<a href={$item.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">
					{attribute_view_gui attribute=$item.data_map.image image_class='mainstory3'}
				</a>
			{else}
				<a href={$item.url_alias|ezurl()}>
					{attribute_view_gui attribute=$item.data_map.image image_class='mainstory3'}
				</a>
			{/if}

		</div>

	{/if}

</div>
</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

</div>
                
                {/foreach}
        
            </div>
            </div>
        </div>        
        
        
        {* TIP A FRIEND *}
        {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}

    </div>
</div>
</div>