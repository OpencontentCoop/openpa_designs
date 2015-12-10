<div class="clearfix included">	
    <h3>
        {include name=edit_buttons node=$node uri='design:parts/openpa/edit_buttons.tpl'}
        {$node.name|wash()}
    </h3>
	{if and( is_set( $node.data_map.image ), $node.data_map.image.has_content )}
        <div class="pull-left">{attribute_view_gui attribute=$node.data_map.image}</div>
	{/if}
	{if $node.data_map.testo_news.has_content}
        <div class="attibute-text">{attribute_view_gui attribute=$node.data_map.testo_news}</div>
	{/if}
</div>
