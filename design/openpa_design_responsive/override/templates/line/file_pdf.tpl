{if is_set( $title_tag )|not()}
    {def $title_tag = 'header'}
{/if}

<div class="class-{$node.class_identifier} line clearfix">

    {include name=buttons node=$node uri='design:parts/openpa/edit_buttons.tpl' css_class="pull-right"} 

	{if and( $node.data_map.file.content.original_filename|ne( concat($node.name, '.', $node.data_map.file.content.mime_type_part) ),
             $node.data_map.file.content.original_filename|ne( $node.name ) )}
		{if $title_tag|eq('header')}<h3>
        {elseif $title_tag|eq('paragraph')}<p><strong>{/if}
                
            {$node.name|wash()}
    
        {if $title_tag|eq('header')}</h3>
        {elseif $title_tag|eq('paragraph')}</strong></p>{/if}	
    {/if}
	
	{if $node.data_map.file.has_content}
		{attribute_view_gui attribute=$node.data_map.file}
	{/if}

</div>
