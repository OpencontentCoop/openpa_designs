{def $valid_node = $block.valid_nodes[0]}

{if $valid_node|not()}
    {set $valid_node = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}
{/if}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">

	{if $block.name}
		<h2 class="block-title">{$block.name}</h2>	
	{/if}

{def

    $event_node    = $valid_node
    $event_node_id = $valid_node.node_id

    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year = $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')
    
    $curr_first = makedate($curr_month, $curr_today, $curr_year)
    $curr_last = makedate($curr_month, sum( $curr_today, 1 ), $curr_year)|sub(1)

    $temp_ts = currentdate()
    $days = $temp_ts|datetime( custom, '%t')
    $static_days = 60|mul( 86400 )

    $temp_month = $temp_ts|datetime( custom, '%n')
    $temp_year = $temp_ts|datetime( custom, '%Y')
    $temp_today = $temp_ts|datetime( custom, '%j')
    
    $first_ts = makedate($temp_month, 1, $temp_year)
    $dayone = $first_ts|datetime( custom, '%w' )
    
    $last_ts = sum( $curr_first, $static_days )
    
    $ezfind_month_first = $first_ts|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
    $ezfind_month_last = $last_ts|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
    $ezfind_curr_first = $curr_first|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
    $ezfind_curr_last = $curr_last|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}

{if and( is_set( $event_node.data_map.subtree_array ), $event_node.data_map.subtree_array.has_content )}
    {def $subtree_array = array()}
    {foreach $event_node.data_map.subtree_array.content.relation_list as $item}
        {set $subtree_array = $subtree_array|append($item.node_id)}
    {/foreach}
{else}
    {def $subtree_array = array( $event_node_id )}
{/if}
    
{def $filters_parameters = getFilterParameters()
    
     $prox_search_hash = hash( 
                        'limit', 100,
                        'subtree_array', $subtree_array,
                        'sort_by', hash( solr_field('from_time','date'), 'asc' ),
                        'filter', array(
                            'or',
                                concat( solr_field('from_time','date'),':[', $ezfind_curr_first, ' TO ', $ezfind_month_last, ']' )
                            )
                       )
     $search_hash = hash( 
                        'limit', 100,
                        'subtree_array', $subtree_array,
                        'sort_by', hash( solr_field('from_time','date'), 'desc' ),
                        'filter', array(
                            'or',
                                concat( solr_field('from_time','date'),':[', $ezfind_curr_first, ' TO ', $ezfind_curr_last, ']' ),
                                concat( solr_field('to_time','date'),':[', $ezfind_curr_first, ' TO ', $ezfind_curr_last, ']' ),
                                array( 'and',
                                    concat( solr_field('from_time','date'),':[* TO ', $ezfind_curr_first, ']' ),
                                    concat( solr_field('to_time','date'),':[', $ezfind_curr_last, ' TO *]' )
                                )
                            )
                       )
     $prox_search = fetch( ezfind, search, $prox_search_hash )
     $search = fetch( ezfind, search, $search_hash )
     $events = $search['SearchResult']
     $events_count  = $search['SearchCount']
     $prossimi = $prox_search['SearchResult']
     $prossimi_count = $prox_search['SearchCount']
     $day_array = " "
     $loop_dayone = 1
     $loop_daylast = 1
     $day_events = array()}

{include name=table_calendar uri='design:content/parts/table_calendar.tpl' timestamp=$temp_ts calendar=$event_node events=$prossimi}

</div>