{* Edizione - Line view *}
{def $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiLine', 'openpa.ini')}

<div id="line-{$node.node_id}" class="content-view-line class-file_pdf line-handler {include uri='design:parts/openpa/line_style.tpl'}">
    
    <div class="blocco-titolo-oggetto">
        <h2>
        {if $node.object.can_edit}
            <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
        {else}
            {$node.name|wash()}
        {/if}
        </h2>
        {foreach $node.object.contentobject_attributes as $attribute}
            {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier) )}
				{if $attribute.has_content}
					{attribute_view_gui href=nolink attribute=$attribute}
				{/if}			
            {/if}			
        {/foreach}
    </div>
    
    <div class="blocco-contenuto-oggetto">
	
		{if $node.data_map.to_time.has_content}
			{if eq( $node.data_map.to_time.content.timestamp|datetime(custom,"%j %M"), 
		   		$node.data_map.from_time.content.timestamp|datetime(custom,"%j %M") )}
				<div class="attribute-edizione-data">
					{$node.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")}; orario:  {$node.data_map.from_time.content.timestamp|datetime(custom,"%G:%i")} - {$node.data_map.to_time.content.timestamp|datetime(custom,"%G:%i")}
				</div>
			{else}
				<div class="attribute-edizionelunga-data">
					Da {$node.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")} a {$node.data_map.to_time.content.timestamp|datetime(custom,"%l %j %F")}
				</div>
			{/if}
		{else}
			<div class="attribute-edizione-data">
				{$node.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")}
			</div>
		{/if}
			

	{def $children=fetch('content', 'list', 
				   hash('parent_node_id', $node.node_id, 'sort_by', 'name',
                             		'class_filter_type', 'include', 'class_filter_array', array('edizione')) )}
 	{if $children|count()|gt(0)}
		<ul>
			{foreach $children as $figlio}
				<li>
					{$figlio.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")}; orario:  {$figlio.data_map.from_time.content.timestamp|datetime(custom,"%G:%i")} - {$figlio.data_map.to_time.content.timestamp|datetime(custom,"%G:%i")}
				</li>
                     	{/foreach}
		</ul>
	{/if}

    </div>
    </div>
</div>
