{*  TEMPLATE DI RICERCA	AVANZATA *}

{if is_set( $use_template_search )}
	{set $use_template_search=true()}
{else}
	{def $use_template_search=true()}
{/if}

{if or( $search_text|eq('Cerca in tutto il sito'), $search_text|eq('Search'), $search_text|eq('Cerca'), $search_text|eq( 'Search'|i18n('design/ezwebin/pagelayout') ) )}
	{set $search_text=''}
{/if}

{* cattura le variabili passate via GET *}
{def $latitude 				    = cond( ezhttp_hasvariable( 'latitude','get','hasVariable' ), ezhttp( 'latitude', 'get' )|wash() )
     $longitude 				= cond( ezhttp_hasvariable( 'longitude','get','hasVariable' ), ezhttp( 'longitude', 'get' )|wash() )
     $address 				    = cond( ezhttp_hasvariable( 'address','get','hasVariable' ), ezhttp( 'address', 'get' ) )
     $anni 				        = cond( ezhttp_hasvariable( 'Anni','get','hasVariable' ), ezhttp( 'Anni', 'get' ) )
	 $interna 			        = cond( ezhttp_hasvariable( 'Interna','get','hasVariable' ), ezhttp( 'Interna', 'get' ) )
	 $Sort 			        	= cond( ezhttp_hasvariable( 'Sort','get','hasVariable' ), ezhttp( 'Sort', 'get' )|wash() )
	 $cond 			        	= cond( ezhttp_hasvariable( 'cond','get','hasVariable' ), ezhttp( 'cond', 'get' )|wash() )
	 $Order 		        	= cond( ezhttp_hasvariable( 'Order','get','hasVariable' ), ezhttp( 'Order', 'get' )|wash() )
	 $classe		        	= cond( ezhttp_hasvariable( 'SearchContentClassID','get','hasVariable' ), ezhttp( 'SearchContentClassID', 'get' ) )
	 $anno_s 		        	= cond( ezhttp_hasvariable( 'anno_s','get','hasVariable' ), ezhttp( 'anno_s', 'get' ) )
     $from       		        = cond( ezhttp( 'from','get','hasVariable' ), ezhttp( 'from', 'get' )|wash() )
	 $from_attributes      		= cond( ezhttp( 'from_attributes','get','hasVariable' ), ezhttp( 'from_attributes', 'get' ) )
	 $to     		        	= cond( ezhttp( 'to','get','hasVariable' ), ezhttp( 'to', 'get' )|wash() )
	 $to_attributes    		    = cond( ezhttp( 'to_attributes','get','hasVariable' ), ezhttp( 'to_attributes', 'get' ) )
	 $SearchButton 		    	= cond( ezhttp_hasvariable( 'SearchButton','get','hasVariable' ), ezhttp( 'SearchButton', 'get' )|wash() )
	 $SubTreeArray 	    	    = cond( ezhttp_hasvariable( 'SubTreeArray','get','hasVariable' ), ezhttp( 'SubTreeArray', 'get' ), false() )
	 $OriginalNodeID 	    	= cond( ezhttp_hasvariable( 'OriginalNode','get','hasVariable' ), ezhttp( 'OriginalNode', 'get' )|wash(), ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )
}

{* altre variabili di default *}
{def $ini_not_available_facets 	= openpaini( 'MotoreRicerca', 'faccette_non_disponibili', array() )
     $ini_not_available_groups 	= openpaini( 'MotoreRicerca', 'gruppi_faccette_non_disponibili', array() )
     $classes_not_available     = openpaini( 'MotoreRicerca', 'classi_non_disponibili', array() )
     $class_group_not_available = openpaini( 'MotoreRicerca', 'gruppi_classi_non_disponibili', array() )
     $not_available_facets      = search_exclude_class_facets()
     $available_classes         = search_include_classes()
     $sort_by 			        = ''
	 $order_by 			        = ''
	 $argomenti_tutti 		    = array()
     $filterParameter           = false()
     $filterParameters          = getFilterParameters()
	 $date				        = false()
	 $search			        = false()
	 $select_sezioni		    = openpaini( 'MotoreDiRicerca', 'RicercaAvanzataSelezionaSezioni', array() )
	 $block_embed_searchbox	    = false()
     $_anni 			        = openpaini( 'MotoreDiRicerca', 'RicercaAvanzataSelezionaAnni', array() )
	 $contentClass			    = array()
     $orig_position             = false()
     $sub_tree                  = array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )
     $geoBoost                  = false()
     $dateFilter                = false()
     $f                         = false()
}

{debug-log var=$not_available_facets.identifiers msg='faccette non visualizzate' }

{* da SubTreeArray a orig_position *}
{if $SubTreeArray}
    {if is_array( $SubTreeArray )|not()}
    {set $SubTreeArray = array( $SubTreeArray )}
    {/if}
    {if $SubTreeArray[0]|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
    {set $orig_position = fetch( content,node,hash( node_id, $SubTreeArray[0] ) )}
    {/if}
{/if}
{if $orig_position}
    {set $sub_tree = array( $orig_position.node_id )}
{/if}


{* nome del bottone *}
{set $SearchButton = 'Cerca'}

{* ordinamento predefiniti in caso di ricerca nulla 
{if $search_text|eq('')}
	{set $Sort = 'published'
		 $Order = 'desc'}
{/if}
*}

{* ordinamento *}
{switch match=$Sort}
	{case match = 'score'}
		{set $sort_by = 'score'}
        {set $Sort = $sort_by}
	{/case}
	{case match = 'published'}
		{set $sort_by = 'published'}
        {set $Sort = $sort_by}
	{/case}
	{case match = 'class_name'}
		{set $sort_by = 'class_name'}
        {set $Sort = $sort_by}
	{/case}
	{case match = 'name'}
		{set $sort_by = 'meta_sort_name_ms'}
	{/case}
	{case}
		{if $Sort|eq( '' )}
            {if $search_text|eq('')}
                {set $sort_by = 'published'}
                {set $Sort = $sort_by}
            {else}
                {set $sort_by = 'score'}
                {set $Sort = $sort_by}
            {/if}
        {else}
            {set $sort_by = $Sort}
        {/if}
	{/case}
{/switch}

{* ordinamento *}
{switch match = $Order}
	{case match = 'desc'}
		{set $order_by = 'desc'}
	{/case}
	{case match = 'asc'}
		{set $order_by = 'asc'}
	{/case}
	{case}
		{set $order_by = 'desc'}
	{/case}
{/switch}

{if and( is_array($anno_s), $anno_s[0]|ne( '' ) )}
    {def $from_year = $anno_s[0]
         $to_year = $from_year|sum(1)}
    {set $dateFilter = concat('[', $from_year, '-01-01T00:59:59.999Z/YEAR TO ', $to_year, '-01-01T00:59:59.999Z/YEAR]')}
{/if}

{if and( $from, $from|ne( '' ) )}
    {def $from_date_array = $from|explode( '-' )
         $from_date = makedate( $from_date_array[1], $from_date_array[0], $from_date_array[2] )|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}
    {if $to}
        {def $to_date_array = $to|explode( '-' )
             $to_date = sum( makedate( $to_date_array[1], $to_date_array[0], $to_date_array[2] ), 86399 )|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}
    {else}
        {def $to_date = sum( makedate( $from_date_array[1], $from_date_array[0], $from_date_array[2] ), 86399 )|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}
    {/if}
    {set $dateFilter = concat('[', $from_date, ' TO ', $to_date, ']')}
{/if}

{if $dateFilter}
	{set $f = setFilterParameter( 'meta_published_dt', $dateFilter )}
{/if}
{debug-log var=$from_attributes msg='from_attributes' }
{debug-log var=$to_attributes msg='to_attributes' }
{if and( $from_attributes, $from_attributes|count()|gt(0) )}
    {foreach $from_attributes as $filter_name => $from_attribute}
        {if $from_attribute|ne( '' )}
            {def $from_attribute_date_array = $from_attribute|explode( '-' )
                 $from_attribute_date = makedate( $from_attribute_date_array[1], $from_attribute_date_array[0], $from_attribute_date_array[2] )|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}
            {if and( $to_attributes, is_set( $to_attributes[$filter_name] ), $to_attributes[$filter_name]|ne( '' ) )}
                {def $to_attribute_date_array = $to_attributes[$filter_name]|explode( '-' )
                     $to_attribute_date = sum( makedate( $to_attribute_date_array[1], $to_attribute_date_array[0], $to_attribute_date_array[2] ), 86399 )|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}
                {undef $to_attribute_date_array}
            {else}
                {def $to_attribute_date = sum( makedate( $from_attribute_date_array[1], $from_attribute_date_array[0], $from_attribute_date_array[2] ), 86399 )|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )}
            {/if}
            {set $f = setFilterParameter( $filter_name, concat('[', $from_attribute_date, ' TO ', $to_attribute_date, ']') )}
            {undef $from_attribute_date_array $from_attribute_date $to_attribute_date $from_attribute_date_array}
        {/if}
    {/foreach}
{/if}

{* controllo filtro sulla classe *}
{def $ClassFilter = getFilterParameter( 'contentclass_id' )}

<div class="row">
<form action={"/content/advancedsearch/"|ezurl} id="ezfindsearch" method="get">
<div class="col-md-{if $ClassFilter|count()|eq(1)}8{else}9{/if}">

{if $ClassFilter|count()|eq(0)}
    
    {foreach $available_classes.ids as $class_id}
        {set $filterParameters = setFilterParameter( 'meta_contentclass_id_si', $class_id )}
    {/foreach}
    
    {debug-log var=$available_classes.identifiers msg='classi incluse nella query' }

{* se si parte dal motore di ricerca globale e si filtra per una sola classe *}
{elseif $ClassFilter|count()|eq(1)}
	{set $contentClass=fetch( 'content', 'class', hash( 'class_id', $ClassFilter[0] ) )}

    {def $OriginalNode = fetch( content, node, hash( node_id, $OriginalNodeID ) ) }
    
    <h4>
        Cerca
        {if $orig_position}
            in "<a href="{$orig_position.url_alias|ezurl(no)}" title='Vai alla pagina "{$orig_position.name|wash}"'>{$orig_position.name|wash}</a>"
        {else}
            in tutto il sito
        {/if}
        solo tra informazioni di tipo "{$contentClass.name}"
    </h4>

    {set-block variable=$block_embed_searchbox}
    {include name       = searchbox 
            node            = $OriginalNode
            subfilter_arr   = $SubTreeArray
            search_text     = $search_text
            class_filters   = $ClassFilter
            search_included = 1
            uri             = 'design:parts/search_class_and_attributes_block.tpl' } 
    {/set-block}

{/if}

{def $memo_search_text=$search_text}
{if $cond|eq('AND')}
	{def $tmp_array=$search_text|explode(' ') $tmp_string='' }
	{foreach $tmp_array as $k => $ts}
		{if $k|eq(0)}
			{set $tmp_string=$ts}
		{else}
			{set $tmp_string=concat($tmp_string, ' AND ', $ts)}
		{/if}
	{/foreach}
	{set $search_text=$tmp_string}
{/if}

{if and( $latitude, $longitude )}
{set $geoBoost = concat( '_val_:\"recip(sqedist(gps_coordinates,vector(', $latitude, ',', $longitude, ')),1,1,0)\"') }
{/if}

{if $use_template_search}
    {set $page_limit = 20
         $filterParameters = getFilterParameters()}

    {def $search_hash = hash(
                            'query', concat( $geoBoost, $search_text ),
                            'offset', $view_parameters.offset,
                            'subtree_array', $sub_tree,
                            'limit', $page_limit,
                            'sort_by', hash( $sort_by, $order_by ),
                            'facet', array( hash( 'field', 'class', 'name', 'Tipologia di contenuto', 'limit', 1000 ) ),
                            'filter', $filterParameters )}

    {set $search            = fetch( ezfind, search, $search_hash )
         $search_text       = $memo_search_text
         $search_count      = $search['SearchCount']
         $search_result     = $search['SearchResult']
         $stop_word_array   = $search['StopWordArray']
         $search_data       = $search}
    
    {def $search_extras=$search['SearchExtras']}
    
    {if is_set( $search_extras.facet_fields.0.field )}
    	{def $facetField = $search_extras.facet_fields.0.field}
    {else}
	    {def $facetField = 'class'}
	{/if}
{/if}

{def $baseURI=concat( '/content/advancedsearch?SearchText=', $search_text )}

{def $uriSuffix = $filterParameters|getFilterUrlSuffix()}

{if $ClassFilter|count()|ne(1)}
    {def $subtree_node = false()
         $sub_tree_name = false()
         $cerca_in_area_tematica = false()}
    
        {if $orig_position}		
            {set $sub_tree_name=$orig_position.name|wash}
            {if $orig_position.class_identifier|eq('area_tematica')}
                {set $cerca_in_area_tematica = true() }
            {/if}
        {/if}
    
        <h4>
            Cerca
            {if and( $sub_tree_name, $cerca_in_area_tematica|not )} 
                solo in "{$sub_tree_name}"
            {elseif and( $sub_tree_name, $cerca_in_area_tematica )} 
                nell area tematica "{$sub_tree_name}"
            {else}
                in tutto il sito
            {/if}
        </h4>
        
        <fieldset>
            <legend class="sr-only">{"Search"|i18n("design/ezwebin/content/search")} {if $sub_tree_name} solo in "{$sub_tree_name}"{else} in tutto il sito{/if}</legend>
    
            <div class="row">
                <div class="col-lg-12">
                    <div class="input-group">
                        <input placeholder="Ricerca libera" class="form-control input-lg" type="text" name="SearchText" id="Search" value="{$search_text|wash}" />                            
                        <span class="input-group-btn">
                            <button type="submit" name="SearchButton" class="btn-primary btn btn-lg" title="{'Search'|i18n('design/ezwebin/content/search')}">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </span>
                    </div>
                    <button type="button" class="btn btn-link btn-xs" data-toggle="collapse" data-target="#AdvancedSearchPanel">
                        Ricerca avanzata
                    </button>
                </div>
            </div>
            
			{if is_area_tematica()}
                <input type="hidden" value="{is_area_tematica().node_id}" name="SubTreeArray[]" />
            {/if}
			
            <div class="row collapse" id="AdvancedSearchPanel">
            <div class="well well-sm clearfix">
                
                <div class="col-xs-3">
                    <div class="form-group">
                        <label for="Sort">Ordina per</label>
                        <select class="form-control" id="Sort" name="Sort">
                            <option value=""> - Seleziona</option>
                            <option {if $Sort|eq('score')} class="marked" selected="selected"{/if} value="score">Rilevanza</option>
                            <option {if $Sort|eq('published')} class="marked" selected="selected"{/if} value="published">Data di pubblicazione</option>
                            <option {if $Sort|eq('class_name')} class="marked" selected="selected"{/if} value="class_name">Tipologia di contenuto</option>
                            <option {if $Sort|eq('name')} class="marked" selected="selected"{/if} value="name">Nome</option>
                        </select>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label for="Order">Ordinamento</label>
                        <select class="form-control" {if $Order}class="marked"{/if} name="Order" id="Order">										
                            <option {if $Order|eq('desc')} class="marked" selected="selected"{/if} value="desc">Discendente</option>
                            <option {if $Order|eq('asc')} class="marked" selected="selected"{/if} value="asc">Ascendente</option>
                        </select>
                    </div>
                </div>
    
                <div class="col-xs-3">
                    <div class="form-group">
                        <label for="anno_s">Anno</label>
                        <select class="form-control" {if is_set($anno_s[0])}class="marked"{/if} id="anno_s" name="anno_s[]">
                            <option value="">Qualsiasi anno</option>
                            {foreach $_anni as $anno}
                            <option {if is_set($anno_s[0])}{if $anno|eq($anno_s[0])} class="marked" selected="selected"{/if}{/if} value="{$anno}">{$anno}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-xs-3">
                    <label>Condizioni logiche</label>
                    <label>
                        <input type="radio" id="radio_and" name="cond" title="AND" value="AND" {if $cond|eq('AND')}checked="checked"{/if} /> AND
                    </label>               
                    <label>
                        <input type="radio" id="radio_and" name="cond" title="OR" value="OR" {if $cond|eq('OR')}checked="checked"{/if} /> OR
                    </label>
                </div>                        
            </div>
            </div>
    
    {set-block variable=$block_search_filter}
    {if and( $SearchButton, $search_count, is_set($search_extras.facet_fields.0.nameList) )}
    {set $filterParameter = getFilterParameter( 'contentclass_id' )}
    
        <h4>
            {if $filterParameter|count()|gt(0)}
                Stai filtrando per:
                {def $stai_filtrando_per="checked='checked'"}
            {else}
                {def $stai_filtrando_per=false()}
                Restringi la ricerca a:
            {/if}
        </h4>
        
        {def $faccette=$search_extras.facet_fields.0.nameList}
        {set $faccette=$faccette|asort()}
        {foreach $faccette as $facetID => $name}							
            {if $not_available_facets.ids|contains($facetID)|not()}
            <div class="checkbox">
                <label>
                    <input value="{$search_extras.facet_fields.0.queryLimit[$facetID]|wash}" title="{$name|wash}" name="filter[]" type="checkbox" {$stai_filtrando_per} /> {$name|wash} ({$search_extras.facet_fields.0.countList[$facetID]})
               </label>
            </div>
               
            {/if}
        {/foreach}
        
        <div class="form-group">
            <input class="btn btn-primary pull-right" name="SearchButton" type="submit" value="{'Search'|i18n('design/ezwebin/content/search')}" />
        </div>
    
    
    {/if}
    {/set-block}
        </fieldset>
{/if}

        
    {* FORSE CERCAVI... *}
    
    {if $search_extras.spellcheck_collation}
        {def $spell_url=concat('content/advancedsearch/',$search_text|count_chars()|gt(0)|choose('',concat('?SearchText=',$search_extras.spellcheck_collation|urlencode)))|ezurl}
        <p><small>
            Forse intendevi cercare per <a href='{$spell_url}'><strong>{$search_extras.spellcheck_collation}</strong></a> ?
        </small></p>
    {/if}
    
    {* PAROLE ESCLUSE *}
    {if $stop_word_array}
        <p><small>
        {"The following words were excluded from the search"|i18n("design/base")}:
        {foreach $stop_word_array as $stopWord}
            {$stopWord.word|wash}
            {delimiter}, {/delimiter}
        {/foreach}
        </small></p>
    {/if}


    {if $SearchButton}
    {switch name=Sw match=$search_count}
        {case match=0}
            <div class="warning">
                {if $search_text|ne('')}
                    <strong>{'No results were found when searching for "%1".'|i18n("design/ezwebin/content/search",,array($search_text|wash))}</strong>
                    {if $search_extras.hasError}{$search_extras.error|wash}{/if}				
                    <p>{'Search tips'|i18n('design/ezwebin/content/search')}</p>
                    <ul>
                        <li>{'Check spelling of keywords.'|i18n('design/ezwebin/content/search')}</li>
                        <li>{'Try changing some keywords (eg, "car" instead of "cars").'|i18n('design/ezwebin/content/search')}</li>
                        <li>{'Try searching with less specific keywords.'|i18n('design/ezwebin/content/search')}</li>
                        <li>{'Reduce number of keywords to get more results.'|i18n('design/ezwebin/content/search')}</li>
                    </ul>
                {else}
                    <strong>Nessun risultato ottenuto</strong>
                    {if $search_extras.hasError}{$search_extras.error|wash}{/if}
                    <p>{'Search tips'|i18n('design/ezwebin/content/search')}</p>
                    <ul>
                        <li>Riduci il numero di filtri applicati</li>
                    </ul>
                {/if}
            </div>
        {/case}
        {case}
            <div class="message-feedback">
            {if $search_text|ne('')}
                <strong>{'Search for "%1" returned %2 matches'|i18n("design/ezwebin/content/search",,array($search_text|wash,$search_count))}</strong>
            {else}
                <strong>La ricerca ha prodotto {$search_count} risultati</strong>
            {/if}
            </div>
        {/case}
    {/switch}

    {if $search_result|count()}
    <div class="table-responsive">
    <table class="table table-compressed table-striped advanced_search" cellspacing="0" cellpadding="0" border="0">
        <thead>
            <tr>
            <th>Risultato della ricerca</th>
            <th>Data</th>
            </tr>
        </thead>
        <tbody>
        {foreach $search_result as $result sequence array(bglight,bgdark) as $bgColor}
           {node_view_gui view=ezfind_advanced_line sequence=$bgColor content_node=$result}
        {/foreach}
        <tr>
            <td colspan="2">
            {include name=Navigator
                 uri='design:navigator/google.tpl'
                 page_uri='content/advancedsearch'
                 page_uri_suffix=concat( '?SearchText=',$search_text|urlencode,'&PhraseSearchText=',$phrase_search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)), $uriSuffix,"&SearchButton=Cerca",cond( is_set($anno_s[0]), concat("&anno_s[]=",$anno_s[0]) ),"&SubTreeArray[]=",$sub_tree[0],"&Sort=",$Sort,"&Order=",$Order,"&cond=",$cond )
                 item_count=$search_count
                 view_parameters=$view_parameters
                 item_limit=$page_limit}
            {/if}		 
            </td>
        </tr>
        </tbody>
    </table>
    </div>
    {/if} {* chiudi SearchButton*}
                            
    </div>

    {if $search_result|count()}
    <div class="col-md-{if $ClassFilter|count()|eq(1)}4{else}3{/if}">
        {if $ClassFilter|count()|ne(1)}
        <div class="panel panel-default margin-top">
            <div class="panel-body">
        {/if}
                {def $link_istruzioni_ricerca = fetch('content','node',hash('node_id', openpaini('LinkSpeciali', 'NodoIstruzioniRicerca', 0) ))}
                {if $link_istruzioni_ricerca}
                <a class="btn btn-xs btn-block" href={$link_istruzioni_ricerca.url_alias|ezurl()} title="Link a {$link_istruzioni_ricerca.name|wash()}">
                    {$link_istruzioni_ricerca.name|wash()}
                </a>
                {/if}
            
                {$block_embed_searchbox}
                
                {if is_set($block_search_filter)}
                    {$block_search_filter}
                {/if}
        {if $ClassFilter|count()|ne(1)}
            </div>
        </div>
        {/if}
    </div>
    {/if}
    
</div>
</form>	
</div>


{ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js', 'ui-datepicker-it.js') )}
{ezcss_require( array( 'datepicker.css' ) )}
<script type="text/javascript">
{literal}
//<![CDATA[
$(function() {

    function ezfTrim( str ) {
        return str.replace(/^\s+|\s+$/g, '') ;
    }

    function ezfGetCookie( name ) {
		var cookieName = 'eZFind_' + name;
		var cookie = document.cookie;
		var cookieList = cookie.split( ";" );
		for( var idx in cookieList ) {
			cookie = cookieList[idx].split( "=" );
			if ( ezfTrim( cookie[0] ) == cookieName ){
				return( cookie[1] );
			}
		}
		return 'none';
    }

    function ezfSetCookie( name, value ){
		var cookieName = 'eZFind_' + name;
		var expires = new Date();
		expires.setTime( expires.getTime() + (365 * 24 * 60 * 60 * 1000));
		document.cookie = cookieName + "=" + value + "; expires=" + expires + ";";
    }

	$.fn.ezfToggleBlock = function(options) {
		return $(this).each(function() {
			/*
			var name = $(this).attr('id');			
			$('#'+name+'Panel').css('display', ezfGetCookie( name ));
			if (ezfGetCookie( name ) == 'none') {
				$(this).removeClass('open');
			}
			*/
			$(this).bind('click', function () {
				name = $(this).attr('id');	
				$('#'+name+'Panel').slideToggle("slow", function() {
					$('#'+name).toggleClass('open');
					var id = $(this).prev().attr('id');
					ezfSetCookie( name, $(this).css('display') )
				});
			});
		});
	};
	$(".eztoggle").ezfToggleBlock();
	
	$(".ezjs_toggleCheckboxes").bind('click', function () {
		$(".filter-container input").each( function() {
			if ($(this).is(':checked'))
				$(this).attr( 'checked', false );
			else
				$(this).attr( 'checked', true );
		});
		return false;
	});
	
	function jtoggleCheckboxes( formname, checkboxname ){
		with( formname ){
			for( var i = 0, l = elements.length; i < l; i++ ){
				if( elements[i].type === 'checkbox' && elements[i].name == checkboxname && elements[i].disabled == false ){
					if( elements[i].checked == true ){
						elements[i].checked = false;
					}else{
						elements[i].checked = true;
					}
				}
			}
		}
	}
    $( "#from" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        changeYear: true,
        dateFormat: "dd-mm-yy",
        numberOfMonths: 1

    });
    $( "#to" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        changeYear: true,
        dateFormat: "dd-mm-yy",
        numberOfMonths: 1
    });
});
//]]>
{/literal}
</script>