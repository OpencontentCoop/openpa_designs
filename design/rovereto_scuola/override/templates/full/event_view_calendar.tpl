{ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js', 'ui-datepicker-it.js' ) )}

<script type="text/javascript">
{literal}
$(function() {	
     $( "#from" ).datepicker({	  
	  changeMonth: true,
	  changeYear: true,
	  numberOfMonths: 1,
	  dateFormat: "dd-mm-yy"
	});
    $( "#to" ).datepicker({	  
	  changeMonth: true,
	  changeYear: true,
	  numberOfMonths: 1,
	  dateFormat: "dd-mm-yy"
	});   
});
{/literal}
</script>

{def $currentInterval = 'P1D'
     $calendarData = fetch( openpa, calendario_eventi, hash( 'calendar', $node,
                                                             'params', hash( 'interval', $currentInterval )|merge( $view_parameters ) ) )
     $day_events = $calendarData.events}

<div class="row class-event-calendar event-calendar-calendarview">
    <div class="col-md-12">
                
        <div class="row">                
            <div class="col-md-10 col-md-offset-1">
                <h1>
                {if $calendarData.parameters.interval|eq('P1D')}
                    Eventi del {$calendarData.parameters.search_from_timestamp|datetime( custom, '%j %F %Y' )|upfirst()}
                {else}
                    Eventi del periodo {$calendarData.parameters.search_from_timestamp|l10n( 'shortdate' )} - {$calendarData.parameters.search_to_timestamp|l10n( 'shortdate' )}
                {/if}
                <br /><small>{$node.name|wash()}</small>
                </h1>
            </div>
        </div>

        {* EDITOR TOOLS *}
        {include name=editor_tools node=$node uri='design:parts/openpa/editor_tools.tpl'}        
        
        <hr />
        
        <form class="calendar-tools" method='GET' action={concat('openpa/calendar/', $node.node_id)|ezurl}>
            <input type='hidden' name="UrlAlias" value="{$node.url_alias}" />            
            <input type='hidden' name="CurrentInterval" value="{$calendarData.parameters.interval}" />

        
            <div class="row">                
                <div class="col-md-5 col-md-offset-1">
                    {*<h4>Cerca per data</h4>*}
                    <p><a href="{$node.url_alias|ezurl(no)}">Eventi di oggi</a></p>
                    <p><a href="{concat($node.url_alias, '/(interval)/P7D')|ezurl(no)}">Eventi dei prossimi 7 giorni</a></p>
                    <p>
                        Da <input style="width: 90px;" id="from" class="calendar_picker" placeholder="gg-mm-yyyy" type="text" name="SearchDate" title="Seleziona data" value="{$calendarData.parameters.search_from_picker_date}" />
						a <input style="width: 90px;" id="to" class="calendar_picker" placeholder="gg-mm-yyyy" type="text" name="SearchEndDate" title="Seleziona data" value="{$calendarData.parameters.search_to_picker_date}" />
                        <input class="btn btn-sm btn-primary" type="submit" name="SearchButton" value="Cerca" />
                    </p>
                </div>
                
                {*<div class="col-md-5">                
                    {if $calendarData.search_facets|count()|gt(0)}
                    <h4>Cerca per classificazione</h4>
                    
                    {foreach $calendarData.search_facets as $facetFieldName => $facets}
                        <p><select name="{$facetFieldName}">
                            <option value="">{$facetFieldName}</option>
                            {foreach $facets as $styleAndName}                
                                <option value="{$styleAndName.value|wash()}"{if $calendarData.parameters[$facetFieldName]|eq($styleAndName.value)} selected="selected"{/if}>{if $styleAndName.indent}&nbsp;&nbsp;&nbsp;{/if}{$styleAndName.name|wash()}</option>
                            {/foreach}            
                        </select></p>
                    {/foreach}
                    <input class="btn btn-sm btn-primary" type="submit" name="SearchButton" value="Cerca" />
                    <input class="btn btn-sm btn-inverse" type="submit" name="TodayButton" value="Azzera ricerca" />                    
                    {/if}
                </div>*}
            </div>

        <hr />
        
        <div class="row">
            
            {def $max = false()
                 $alreadyShow = array()}
            {if count($day_events)|gt(0)}
            <div class="col-md-10 col-md-offset-1">        
                {if count($day_events)|gt(2)}
                    {set $max = floor( count($day_events)|div(2) )}
                {else}
                    {set $max = 1}
                {/if}
                
                <div class="row">
                    <div class="col-md-6">        
                    {foreach $day_events as $day_event max $max}
                        {set $alreadyShow = $alreadyShow|append($day_event.id)}
                        {include name=event uri='design:block_item/event.tpl' node=$day_event.node}                        
                    {/foreach}
                    </div>
                    <div class="col-md-6">        
                    {foreach $day_events as $day_event offset $max}
                        {set $alreadyShow = $alreadyShow|append($day_event.id)}
                        {include name=event uri='design:block_item/event.tpl' node=$day_event.node}                        
                    {/foreach}
                    </div>                    
                </div>
            </div>
            {/if}

          
        </div>
    </div>
</div>

{undef}
