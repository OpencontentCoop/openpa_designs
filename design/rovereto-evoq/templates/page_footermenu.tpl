{if $current_node.class_identifier|eq( 'ufficio' )}
    {def $servizi_erogati = fetch( 'content', 'list', hash( 'parent_node_id', $current_node.node_id,
                                                           'sort_by', $current_node.sort_array,
                                                           'class_filter_type', 'include',
                                                           'class_filter_array', array( 'scheda_informativa' ) ) )}
    {if count( $servizi_erogati )|gt(0)}
        {def $limit = count($servizi_erogati)|div(3)|ceil()}
        <div class="row-fp">
        <div class="row frontpage">
            
            <div class="col-md-12">
                <div class="ezpage-block">
                    <h2>Servizi erogati</h2>
                </div>
            </div>
            
            <div class="col-md-4">       
            {foreach $servizi_erogati as $index => $se max $limit}
                {include uri='design:parts/footermenu_block.tpl' node=$se index=$index}
            {/foreach}
            </div>
            <div class="col-md-4">       
            {foreach $servizi_erogati as $index => $se max $limit offset $limit}
                {include uri='design:parts/footermenu_block.tpl' node=$se index=$index|inc($limit)}
            {/foreach}
            </div>
            <div class="col-md-4">       
            {foreach $servizi_erogati as $index => $se offset $limit|mul(2)}
                {include uri='design:parts/footermenu_block.tpl' node=$se index=$index}
            {/foreach}
            </div>
        </div>
        </div>
        {undef $limit}
    {/if}
{/if}

{if $current_node.class_identifier|eq( 'event' )}
    {def $calendarData = fetch( openpa, calendario_eventi, hash( 'calendar', $current_node.parent, 'params', hash( 'interval', 'P2Y',
                                                                                                               'filter', array( concat( '-meta_id_si:', $current_node.contentobject_id ) ),
                                                                                                               'day', 1,
                                                                                                               'month', 1,                                                                                                               
                                                                                                               'Manifestazione', $current_node.name ) ) )}

    {if $calendarData.search_count|gt(0)}        
        <div class="row-fp">
        <div class="row events-related">
            
            <div class="col-md-12">
                <div class="ezpage-block">
                    <h2>Eventi in programma</h2>
                </div>
            </div>
        </div>        

        {foreach $calendarData.events as $i => $event}
          {if $i|eq(0)}<div class="row">{/if}
            <div class="col-md-4">       
              {include name=event uri='design:block_item/event.tpl' node=$event.node}
            </div>
          {if eq(sum($i,1)|mod(3),0)}</div><div class="row">{/if}
          {if $i|eq($calendarData.search_count|sub(1))}</div>{/if}    
        {/foreach}
            
        </div>
    {/if}
{/if}