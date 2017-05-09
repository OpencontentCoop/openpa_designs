{if is_set( $item.from )}
    {def $month = $item.from|datetime( 'custom', '%M' )
    $day = $item.from|datetime( 'custom', '%j' )
    $sameDay = cond($item.to|sub($item.from)|le(86400), true(), false())
    $__node = $item.node}
{else}
    {def $month = $item.data_map.from_time.content.timestamp|datetime( 'custom', '%M' )
    $day = $item.data_map.from_time.content.timestamp|datetime( 'custom', '%j' )
    $sameDay = cond($item.data_map.to_time.content.timestamp|sub($item.data_map.from_time.content.timestamp)|le(86400), true(), false())
    $__node = $item}
{/if}

<div class="event-item row">
    <div class="col-xs-5">
        <div class="calendar-date">
            {if $sameDay|not()}
                <span class="month"><small>dal </small></span>
            {/if}
            <span class="day">{$day} {$month}</span>
        </div>
    </div>
    <div class="col-xs-7" style="padding-left: 0">
        <div class="calendar-title">
            {node_view_gui content_node=$__node view=text_linked shorten=80}
        </div>
    </div>
</div>

{undef $month $day $__node $sameDay}
