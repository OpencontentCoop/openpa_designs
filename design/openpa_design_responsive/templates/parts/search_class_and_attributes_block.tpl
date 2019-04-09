{*
	BLOCCO di ricerca

	node			ID nodo del folder, a cui limitare la ricerca
	class_filters		array di classi a cui limitare la ricerca
	servizi			array di servizi
	anno_s			array di anni
	argomenti		array di argomenti
	subfilter_arr		array dei campi valorizzati e ricercabili
	search_text		testo contenente la ricerca aperta
	folder			nome del contenitore
	search_included		esiste se il template è incluso in search.tpl
	sub_tree		array sottoalbero a cui limitare la ricerca

*}

{def $Sort = cond( ezhttp( 'Sort','get','hasVariable' ), ezhttp( 'Sort', 'get' )|wash() )
     $Order = cond( ezhttp( 'Order','get','hasVariable' ), ezhttp( 'Order', 'get' )|wash() )
     $from = cond( ezhttp( 'from','get','hasVariable' ), ezhttp( 'from', 'get' )|wash() )
	 $to = cond( ezhttp( 'to','get','hasVariable' ), ezhttp( 'to', 'get' )|wash() )
     $from_attributes = cond( ezhttp( 'from_attributes','get','hasVariable' ), ezhttp( 'from_attributes', 'get' ) )
     $to_attributes = cond( ezhttp( 'to_attributes','get','hasVariable' ), ezhttp( 'to_attributes', 'get' ) )}

{switch match=$Sort}	
	{case}
		{if $Sort|eq( '' )}
            {if $search_text|eq('')}
                {set $Sort = 'published'}
            {else}
                {set $Sort = 'score'}
            {/if}
        {/if}
	{/case}
{/switch}

{ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js', 'ui-datepicker-it.js' ) )}
<script type="text/javascript">
{literal}
$(function() {
	$(".block-search-advanced-link p").click(function () {
		$(this).toggleClass('open');
		$(this).next().slideToggle("slow");		
    });
    $( ".from_picker" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        changeYear: true,
        dateFormat: "dd-mm-yy",
        numberOfMonths: 1

    });
    $( ".to_picker" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        changeYear: true,
        dateFormat: "dd-mm-yy",
        numberOfMonths: 1
    });    
});
{/literal}
</script>

{if is_set($search_included)|not()}
    {def $search_included = false()}
{/if}

{if is_set($search_text)|not()}
    {def $search_text = ''}
{/if}

{def $filterParameter = array()
     $SubTreeArray = cond( ezhttp( 'SubTreeArray','get','hasVariable' ), ezhttp( 'SubTreeArray', 'get' ), array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}

{def $subtreearray = array(ezini( 'NodeSettings', 'RootNode', 'content.ini' )) }

{if is_set($subtree)}
    {set $subtreearray = $subtree}
{/if}

{if $SubTreeArray}
    {if and( is_array( $SubTreeArray )|not(), $SubTreeArray|ne('') )}
    {set $SubTreeArray = array( $SubTreeArray )}
    {else}
    {def $tempSta = array()}
    {foreach $SubTreeArray as $sta}
        {if and( $sta|ne(ezini( 'NodeSettings', 'RootNode', 'content.ini' )), $sta|ne('') )}
            {set $tempSta = $tempSta|append($sta)}
        {/if}
    {/foreach}
    {set $subtreearray = $tempSta}
    {/if}
{/if}

{if and( $subtreearray|contains(ezini( 'NodeSettings', 'RootNode', 'content.ini' )), count($subtreearray)|gt(1) )}
    {def $tempSta = array()}
    {foreach $subtreearray as $sta}
        {if and( $sta|ne(ezini( 'NodeSettings', 'RootNode', 'content.ini' )), $sta|ne('') )}
            {set $tempSta = $tempSta|append($sta)}
        {/if}
    {/foreach}
    {set $subtreearray = $tempSta}
{/if}

{def $activeFacetParameters = array()}
{if ezhttp_hasvariable( 'activeFacets', 'get' )}
    {set $activeFacetParameters = ezhttp( 'activeFacets', 'get' )}
{/if}


{def $class = ''
	 $attributi_da_escludere_dalla_ricerca  = openpaini( 'Attributi', 'EscludiDaRicerca', array())
	 $anni = openpaini( 'MotoreDiRicerca', 'RicercaAvanzataSelezionaAnni', array() )}

{foreach $class_filters as $class_filter}
    {set $class = fetch( 'content', 'class', hash( 'class_id', $class_filter ) )}
{/foreach}

<ul class="pager">  
  <li class="previous"><a href={concat( "/content/advancedsearch/", cond( is_area_tematica(), concat( '?SubTreeArray[]=', is_area_tematica().node_id ), '' ) )|ezurl()}>&larr; Ricerca generale</a></li>  
</ul>

<fieldset>
    {if is_array($subtreearray)}
		{set $subtreearray = $subtreearray|unique()} 
        {foreach $subtreearray as $sta}
			<input name="SubTreeArray[]" type="hidden" value="{$sta}" />
		{/foreach}
	{/if}
	
    <div class="form-group">
        <input placeholder="Ricerca libera" class="form-control" type="text" name="SearchText" value="{$search_text}" />
    </div>

    
    {if $class_filters[0]|ne('')}
    
        {def $sorters = array()
             $filter_string = ''}
            {foreach $class.data_map as $attribute}
            {if and($attribute.is_searchable, $attribute.identifier|ne('errors'), $attributi_da_escludere_dalla_ricerca|contains($attribute.identifier)|not())}
                {switch match=$attribute.data_type_string}
                    {case in=array('ezstring','eztext')}
                       {set $sorters = $sorters|append( hash( 'name', $attribute.name, 'value', solr_field( $attribute.identifier, 'string' ) ) )}
                    {/case}
                    {case in=array('ezdate', 'ezdatetime')}
                        {set $filter_string = solr_field( $attribute.identifier, 'date' )}
                        {set $sorters = $sorters|append( hash( 'name', $attribute.name, 'value', $filter_string ) )}
                    {/case}
                    {case in=array('ezinteger')}
                        {set $sorters = $sorters|append( hash( 'name', $attribute.name, 'value', solr_field( $attribute.identifier, 'sint' ) ) )}
                    {/case}
                    {case}{/case}
            {/switch}
        {/if}
        {/foreach}
    {/if}

    <button type="button" class="btn btn-link btn-sm" data-toggle="collapse" data-target="#OrderSearchPanel">
        Ordinamento dei risultati
    </button>
    
    <button type="button" class="btn btn-link btn-sm" data-toggle="collapse" data-target="#AdvancedSearchPanel">
        Ricerca avanzata
    </button>
    
    <div class="well well-sm clearfix collapse" id="OrderSearchPanel">
        <div class="form-group">
            <label for="Sort">Ordina per</label>
            <select class="form-control" id="Sort" name="Sort">
                <option value=""> - Seleziona</option>
                <option {if $Sort|eq('published')} class="marked" selected="selected"{/if} value="published">Data di pubblicazione</option>
                <option {if $Sort|eq('score')} class="marked" selected="selected"{/if} value="score">Rilevanza</option>
                {*<option {if $Sort|eq('class_name')} class="marked" selected="selected"{/if} value="class_name">Tipologia di contenuto</option>*}
                {foreach $sorters as $sorter}
                    {if and( $sorter.name|ne( 'Nome' ), $sorter.name|ne( 'Rilevanza' ), $sorter.name|ne( 'Tipologia di contenuto' ), $sorter.name|ne( 'Data di pubblicazione' ) )}
                        <option {if $Sort|eq($sorter.value)} class="marked" selected="selected"{/if} value="{$sorter.value}">{$sorter.name}</option>
                    {/if}
                {/foreach}
            </select>
        </div>
        
        <div class="form-group">
            <label for="Order">Ordinamento</label>
            <select class="form-control" {if $Order}class="marked"{/if} name="Order" id="Order">										
                <option {if $Order|eq('desc')} class="marked" selected="selected"{/if} value="desc">Discendente</option>
                <option {if $Order|eq('asc')} class="marked" selected="selected"{/if} value="asc">Ascendente</option>
            </select>
        </div>
    </div>    


{if $class_filters[0]|ne('')}
    
    {def $facets = array()}
    <div class="well well-sm clearfix collapse in" id="AdvancedSearchPanel">
        {foreach $class.data_map as $attribute}
        {if and($attribute.is_searchable, $attribute.identifier|ne('errors'), $attributi_da_escludere_dalla_ricerca|contains($attribute.identifier)|not())}
            {switch match=$attribute.data_type_string}
                
                {case in=array('ezstring','eztext')}
                {set $filterParameter = getFilterParameter( solr_field( $attribute.identifier, 'text' ) )}
                    <div class="form-group">
                        <label for="{$attribute.identifier}">{$attribute.name}</label>
                        <input class="form-control" id="{$attribute.identifier}" type="text" name="filter[{solr_field( $attribute.identifier, 'text' )}]" value="{if is_set($filterParameter[0])}{$filterParameter[0]}{/if}" />
                    </div>
                {/case}
                
                {case in=array('ezobjectrelationlist')}
                    {set $facets = $facets|append( hash( 'field', solr_meta_subfield( $attribute.identifier, 'main_node_id' ), 'name', $attribute.name, 'limit', 10 ) )}
                {/case}
                
                {case}
                {/case}
                
                
                {case in=array('ezdate', 'ezdatetime')}
                    {set $filter_string = solr_field( $attribute.identifier, 'date' )}
                    {set $sorters = $sorters|append( hash( 'name', $attribute.name, 'value', $filter_string ) )}
                    {if $attribute.identifier|eq('data_archiviazione')|not()}
	                    <fieldset>
        	                <legend>{$attribute.name}:</legend>
                	        <div class="form-group">
                                <label for="from">Dalla data: <small class="no-js-show"> (GG-MM-AAAA)</small></label>
                                <input type="text" class="form-control  from_picker" name="from_attributes[{$filter_string}]" title="Dalla data" value="{if is_set($from_attributes[$filter_string])}{$from_attributes[$filter_string]|wash()}{/if}" />
                            </div>
                            <div class="form-group">
                                <label for="to">Alla data: <small class="no-js-show"> (GG-MM-AAAA)</small></label>
                                <input class="form-control to_picker" type="text" name="to_attributes[{$filter_string}]" title="Alla data" value="{if is_set($to_attributes[$filter_string])}{$to_attributes[$filter_string]|wash()}{/if}" />
                            </div>
                	    </fieldset>
                    {/if}                    
                {/case}
                
                {case in=array('ezinteger')}
                    {if $attribute.identifier|eq('annoxxx')}
                    <div class="form-group">
                        <label for="{$attribute.identifier}">{$attribute.name}</label>
                        <select class="form-control" id="{$attribute.identifier}" name="anno_s[]">
                                <option value="">Qualsiasi anno</option>
                                {foreach $anni as $anno}
                                <option {if $anno|eq($anno_s[0])} class="marked" selected="selected"{/if} value="{$anno}">{$anno}</option>
                                {/foreach}
                        </select>
                    </div>
                    {else}
                        {set $filterParameter = getFilterParameter( solr_field( $attribute.identifier, 'sint' ) )}
                    <div class="form-group">
                        <label for="{$attribute.identifier}">{$attribute.name}</label>
                        <input class="form-control" id="{$attribute.identifier}" size="5" type="text" name="filter[{solr_field( $attribute.identifier, 'sint' )}]" value="{if is_set($filterParameter[0])}{$filterParameter[0]}{/if}" />
                    </div>
                    {/if}
                    {set $sorters = $sorters|append( hash( 'name', $attribute.name, 'value', solr_field( $attribute.identifier, 'sint' ) ) )}
                {/case}            
            {/switch}
        {/if}
        {/foreach}
    
            <fieldset>
                <legend>Data di pubblicazione:</legend>
                <div class="form-group">
                    <label for="from">Dalla data: <small class="no-js-show"> (GG-MM-AAAA)</small></label>
                    <input type="text" class="form-control from_picker" name="from" title="Dalla data" value="{if $from}{$from}{/if}" />
                </div>
                <div class="form-group">
                    <label for="to">Alla data: <small class="no-js-show"> (GG-MM-AAAA)</small></label>
                    <input class="form-control to_picker" type="text" name="to" title="Alla data" value="{if $to}{$to}{/if}" />
                </div>
            </fieldset>
    
            <input name="filter[]" value="contentclass_id:{$class.id}" type="hidden" />
            <input name="OriginalNode" value="{$node.node_id}" type="hidden" />

    {if count($facets)}
        {def $filters_parameters = getFilterParameters()
             $cleanFilterParameters = array()
             $tempFilter = false()}
        
        {def $query = cond( ezhttp( 'SearchText','get','hasVariable' ), ezhttp( 'SearchText', 'get' )|wash(), '' )}
        {if count( $subtreearray )|eq(0)}
            {set $subtreearray = array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
        {/if}
        {def $filters_hash = hash( 'query', $query,
                                      'class_id', array( $class.id ),
                                      'limit', 1,
                                      'subtree_array', $subtreearray,
                                      'sort_by', hash( 'score', 'desc' ),
                                      'facet', $facets,
                                      'filter', $filters_parameters
                                     )
             $filters_search = fetch( ezfind, search, $filters_hash )
             $filters_search_extras = $filters_search['SearchExtras']
        }
        
        {def $nameList = array()}
        
        {def $baseURI=concat( '/content/advancedsearch?', 'OriginalNode=', $node.node_id, '&SearchText=', $search_text, '&SubTreeArray[]=', $subtreearray|implode( '&SubTreeArray[]=' ) )}
        {def $uriSuffix = $filters_parameters|getFilterUrlSuffix()}
        {foreach $activeFacetParameters as $facetField => $facetValue}
            {set $uriSuffix = concat( $uriSuffix, '&activeFacets[', $facetField, ']=', $facetValue )}
        {/foreach}
        {set $uriSuffix = concat( $uriSuffix, "&Sort=",$Sort,"&Order=",$Order,"&from=",$from,"&to=",$to )}
       
        {foreach $facets as $key => $facet}            
            {if $filters_search_extras.facet_fields.$key.nameList|count()}
                <fieldset>
                <legend>{$facet['name']}</legend>
                
                {if count($filters_search_extras.facet_fields.$key.nameList)|gt(5)}
                    <div class="form-group">
                    <select class="form-control" name="filter[]">
                        <option value=""> - Seleziona</option>
                    {foreach $filters_search_extras.facet_fields.$key.nameList as $key2 => $facetName}
                        {if ne( $key2, '' )}
                            {def $filterName = $filters_search_extras.facet_fields.$key.queryLimit[$key2]|explode(':')
                                 $filterValue = getFilterParameter( $filterName[0] )}
                            <option {if $filterValue|contains( $facetName )} selected="selected" {/if} value='{$filters_search_extras.facet_fields.$key.queryLimit[$key2]}'>{if fetch( 'content', 'node', hash( 'node_id', $facetName ))}{fetch( 'content', 'node', hash( 'node_id', $facetName )).name|wash()}{else}{$facetName}{/if} ({$filters_search_extras.facet_fields.$key.countList[$key2]})</option>
                            {undef $filterName $filterValue}
                        {/if}
                    {/foreach}
                    </select>
                    </div>
                {else}
                    {foreach $filters_search_extras.facet_fields.$key.nameList as $key2 => $facetName}
                        {if ne( $key2, '' )}
                            {def $filterName = $filters_search_extras.facet_fields.$key.queryLimit[$key2]|explode(':')
                                 $filterValue = getFilterParameter( $filterName[0] )}                            
                            <div class="checkbox">
                            <label>
                                <input {if $filterValue|contains( $facetName )} checked="checked" {/if} class="inline" type="checkbox" name="filter[]" value='{$filters_search_extras.facet_fields.$key.queryLimit[$key2]}' /> {if fetch( 'content', 'node', hash( 'node_id', $facetName ))}{fetch( 'content', 'node', hash( 'node_id', $facetName )).name|wash()}{else}{$facetName}{/if} ({$filters_search_extras.facet_fields.$key.countList[$key2]})
                            </label>
                            </div>
                            {undef $filterName $filterValue}
                        {/if}
                    {/foreach}
                {/if}
                </fieldset>
            {else}
                {def $filterValue = getFilterParameter( $facet.field )} 
                {if count( $filterValue )|gt(0)}
                <fieldset>
                    <legend>{$facet['name']}</legend>
                    <div class="checkbox">
                    <label>
                        <input checked="checked" class="inline" type="checkbox" name="filter[]" value='{concat( $facet.field, ':', $filterValue[0] )}' /> {if fetch( 'content', 'node', hash( 'node_id', $filterValue[0] ))}{fetch( 'content', 'node', hash( 'node_id', $filterValue[0] )).name|wash()}{else}{$filterValue[0]}{/if}
                    </label>
                    </div>
                </fieldset>
                {/if}
                {undef $filterValue}
            {/if}
            
        {/foreach}
       
    {/if}
    </div>

{/if}
    <div class="form-group">
    	<input id="search-button-button" class="btn btn-lg btn-primary pull-right" type="submit" name="SearchButton" value="Cerca" />
    </div>
</fieldset>
