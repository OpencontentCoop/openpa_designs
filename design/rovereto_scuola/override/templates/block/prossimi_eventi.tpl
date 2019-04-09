{def $valid_node = cond( is_set( $block.valid_nodes[0] ), $block.valid_nodes[0], false() )
$show_link = true()}

{if and( $valid_node|not(), is_set( $block.custom_attributes.source ) )}
    {set $valid_node = fetch( content, node, hash( node_id, $block.custom_attributes.source ) )}
{/if}

{if $valid_node|not()}
    {set $valid_node = fetch( content, node, hash( node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )
    $show_link = false()}
{/if}


{def $currentInterval = 'P2M'
$calendarData = calendar( $valid_node, hash( 'interval', $currentInterval, 'view', 'program' ) ) }

{if $calendarData.search_count|gt(0)}
    <div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
        {if $block.name|ne('')}
            <h2>
                {if $show_link}
                    <a href="{$valid_node.url_alias|ezurl(no)}" title="Vai al calendario">{$block.name|wash()}</a>
                {else}
                    {$block.name|wash()}
                {/if}
            </h2>
        {/if}
        {foreach $calendarData.day_by_day as $calendarDay}
            {if $calendarDay.count|gt(0)}

                <div class="calendar-day-program float-break" id="day-{$calendarDay.identifier}">
                    {foreach $calendarDay.events as $event max 5}
                        {include uri="design:calendar/block_list_item.tpl" item=$event}
                    {/foreach}
                </div>
            {/if}
        {/foreach}
    </div>
{/if}
