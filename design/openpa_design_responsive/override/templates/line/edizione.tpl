{if is_set( $title_tag )|not()}{def $title_tag = 'header'}{/if}

<div class="class-{$node.class_identifier} line clearfix">
    {if $title_tag|eq('header')}<h3>
    {elseif $title_tag|eq('paragraph')}<strong><p>{/if}
        <a href={$node.url_alias|ezurl} title="{$node.name|wash}">{$node.name|wash}</a>
    {if $title_tag|eq('header')}</h3>
    {elseif $title_tag|eq('paragraph')}</strong></p>{/if}
    
    {if $node.data_map.to_time.has_content}
        {if eq( $node.data_map.to_time.content.timestamp|datetime(custom,"%j %M"), 
            $node.data_map.from_time.content.timestamp|datetime(custom,"%j %M") )}
            <p class="attribute-edizione-data">
                {$node.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")}; orario:  {$node.data_map.from_time.content.timestamp|datetime(custom,"%G:%i")} - {$node.data_map.to_time.content.timestamp|datetime(custom,"%G:%i")}
            </p>
        {else}
            <p class="attribute-edizionelunga-data">
                Da {$node.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")} a {$node.data_map.to_time.content.timestamp|datetime(custom,"%l %j %F")}
            </p>
        {/if}
    {else}
        <p class="attribute-edizione-data">
            {$node.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")}
        </p>
    {/if}
			

	{def $children=fetch('content', 'list', 
				   hash('parent_node_id', $node.node_id, 'sort_by', 'name',
                             		'class_filter_type', 'include', 'class_filter_array', array('edizione')) )}
 	{if $children|count()|gt(0)}
        <ul>
        {foreach $children as $figlio}
            <li>
            {$figlio.data_map.from_time.content.timestamp|datetime(custom,"%l %j %F")};
            orario:  {$figlio.data_map.from_time.content.timestamp|datetime(custom,"%G:%i")} - {$figlio.data_map.to_time.content.timestamp|datetime(custom,"%G:%i")}
            </li>
        {/foreach}
        </ul>
	{/if}

</div>
