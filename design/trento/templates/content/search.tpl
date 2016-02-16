{*  TEMPLATE DI RICERCA	 *}

{if is_set( $use_template_search )}
	{set $use_template_search=true()}
{else}
	{def $use_template_search=true()}
{/if}

{if or( $search_text|eq('Cerca in tutto il sito'), $search_text|eq('Search'), $search_text|eq('Cerca') )}
	{set $search_text=''}
{/if}

{* cattura le variabili passate via GET *}
{def $not_available_facets 		= ezini( 'MotoreRicerca', 'faccette_non_disponibili', 'openpa.ini')
	 $latitude 				    = cond( ezhttp( 'latitude','get','hasVariable' ), ezhttp( 'latitude', 'get' ) )
     $longitude 				= cond( ezhttp( 'longitude','get','hasVariable' ), ezhttp( 'longitude', 'get' ) )
     $address 				    = cond( ezhttp( 'address','get','hasVariable' ), ezhttp( 'address', 'get' ) )
     $anni 				        = cond( ezhttp( 'Anni','get','hasVariable' ), ezhttp( 'Anni', 'get' ) )
	 $interna 			        = cond( ezhttp( 'Interna','get','hasVariable' ), ezhttp( 'Interna', 'get' ) )
	 $Sort 			        	= cond( ezhttp( 'Sort','get','hasVariable' ), ezhttp( 'Sort', 'get' ), '' )
	 $cond 			        	= cond( ezhttp( 'cond','get','hasVariable' ), ezhttp( 'cond', 'get' ) )
	 $Order 		        	= cond( ezhttp( 'Order','get','hasVariable' ), ezhttp( 'Order', 'get' ), '' )
	 $classe		        	= cond( ezhttp( 'SearchContentClassID','get','hasVariable' ), ezhttp( 'SearchContentClassID', 'get' ) )
	 $anno_s 		        	= cond( ezhttp( 'anno_s','get','hasVariable' ), ezhttp( 'anno_s', 'get' ) )
	 $from       		        = cond( ezhttp( 'from','get','hasVariable' ), ezhttp( 'from', 'get' ) )
	 $from_attributes      		= cond( ezhttp( 'from_attributes','get','hasVariable' ), ezhttp( 'from_attributes', 'get' ) )
	 $to     		        	= cond( ezhttp( 'to','get','hasVariable' ), ezhttp( 'to', 'get' ) )
	 $to_attributes    		    = cond( ezhttp( 'to_attributes','get','hasVariable' ), ezhttp( 'to_attributes', 'get' ) )
	 $SearchButton 		    	= cond( ezhttp( 'SearchButton','get','hasVariable' ), ezhttp( 'SearchButton', 'get' ) )
	 $SubTreeArray 	    	    = cond( ezhttp( 'SubTreeArray','get','hasVariable' ), ezhttp( 'SubTreeArray', 'get' ), false() )
	 $OriginalNodeID 	    	= cond( ezhttp( 'OriginalNode','get','hasVariable' ), ezhttp( 'OriginalNode', 'get' ), 2 )
     $phrase_search_text        = ''
}

{* altre variabili di default *}
{def $sort_by 			    = ''
	 $order_by 			    = ''
	 $argomenti_tutti 		= array()
	 $available_classes		= array( 36,37,40,38,73,72,75,96,121,109,103,4 )
     $filterParameter       = false()     
	 $date				    = false()
	 $search			    = false()
	 $select_sezioni		= array( 1026, 53937, 53943, 156904, 54603)
	 $block_embed_searchbox	= false()
     $_anni 			    = array( '2012', '2011','2010','2009','2008','2007','2006','2005','2004','2003','2002','2001' )
	 $contentClass			= array()
     $orig_position         = false()
     $sub_tree              = array()
     $geoBoost              = false()
     $dateFilter            = false()
     $f                     = false()
}

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

{* filtri su data *}
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
	{set $f = setFilterParameter( 'published', $dateFilter )}
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
{if $ClassFilter|count()|eq(1) }
	 {set $contentClass=fetch( 'content', 'class', hash( 'class_id', $ClassFilter[0] ) )}
{/if}

{* ordinamento di default per singola classe *}
{if and( $ClassFilter|count()|eq(1), ezini_hasvariable( 'MotoreRicerca', concat( 'ordinamento_', $contentClass.identifier, '_default' ), 'openpa.ini' ) )}
	 {def $class_sort_order_default = ezini( 'MotoreRicerca', concat( 'ordinamento_', $contentClass.identifier, '_default' ), 'openpa.ini' )|explode( ';' )}
{/if}
{def $sort_default = 'name'}
{if and( $ClassFilter|count()|eq(1), ezini_hasvariable( 'MotoreRicerca', concat( 'ordinamento_', $contentClass.identifier ), 'openpa.ini' ) )}
	 {set $sort_default = ezini( 'MotoreRicerca', concat( 'ordinamento_', $contentClass.identifier ), 'openpa.ini' )}
{/if}

{* ordinamento *}
{if $Sort|eq( '' )}
	 {if is_set( $class_sort_order_default[0] )}
		  {set $sort_by = $class_sort_order_default[0]}
	 {elseif $search_text|eq('')}
		  {set $sort_by = 'published'}
	 {else}
		  {set $sort_by = 'score'}
	 {/if}
{else}
	 {set $sort_by = $Sort}
{/if}
{if $Order|eq( '' )}
	 {if is_set( $class_sort_order_default[1] )}
		  {set $order_by = $class_sort_order_default[1]}
	 {else}
		  {set $order_by = 'desc'}
	 {/if}
{else}
	 {set $order_by = $Order}
{/if}
{debug-log var=array( $sort_by, $order_by, cond( is_set( $class_sort_order_default ), $class_sort_order_default ), $sort_default ) msg='sort order class_sort_order_default sort_default' }

<form action={"/content/advancedsearch/"|ezurl} id="ezfindsearch" method="get">
<div class="border-box search-page{if $OriginalNodeID|not()} search-full{/if} class-filter-count-{$ClassFilter|count()} extrainfo">
    <div class="columns-search float-break">
        <div class="main-column-position">
            <div class="main-column float-break">
                <div class="border-box">
                <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
                <div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

                        <div class="content-view-full">
                            <div class="float-break">

{* se si effettua una ricerca dal box colonna destra per una classe specifica 

{if $ClassFilter|count()|ne(1)}

{if $OriginalNodeID}
	{def $OriginalNode = fetch( content, node, hash( node_id, $OriginalNodeID ) ) }
	<div class="attribute-header"><h1>{"Search"|i18n("design/ezwebin/content/search")}</h1></div>
	
{set-block variable=$block_embed_searchbox}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">
	{include name       = searchbox 
		node            = $OriginalNode
		folder          = $OriginalNode.name
		search_text     = $search_text
		class_filters   = $classes_id
		search_included = 1
		uri             = 'design:parts/search_class_and_attributes_block.tpl' }    
</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>        
{/set-block}

{/if}
*}


{* se si parte dal motore di ricerca globale e si filtra per una sola classe *}
{if $ClassFilter|count()|eq(1)}	
    {def $OriginalNode = fetch( content, node, hash( node_id, $OriginalNodeID ) ) }
    
	<div class="attribute-header">
        <h1>{"Search"|i18n("design/ezwebin/content/search")}
        {if $orig_position}
            in "{$orig_position.name|wash}"
        {else}
            in tutto il sito
        {/if}
        solo tra informazioni di tipo "{$contentClass.name}"</h1>
    </div>

{set-block variable=$block_embed_searchbox}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">
	{include name       = searchbox 
		node            = $OriginalNode
        sub_tree        = $sub_tree
		search_text     = $search_text
		class_filters   = $ClassFilter
		search_included = 1
		sort_by			= $sort_by
		order_by		= $order_by
		uri             = 'design:parts/search_class_and_attributes_block.tpl' } 
</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>         
{/set-block}

{/if}

{def $memo_search_text=$search_text}
{if $cond|eq('AND')}
	{def $tmp_array=$search_text|explode(' ')
         $tmp_string='' }
	{foreach $tmp_array as $k => $ts}
		{if $k|eq(0)}
			{set $tmp_string=$ts}
		{else}
			{set $tmp_string=concat($tmp_string, ' AND ', $ts)}
		{/if}
	{/foreach}
	{set $search_text=$tmp_string}
{/if}

{*if and( $latitude, $longitude )}
{set $geoBoost = concat( '_val_:\"recip(sqedist(gps_coordinates,vector(', $latitude, ',', $longitude, ')),1,1,0)\"') }
{/if*}

{if $use_template_search}
    {set $page_limit = 50}
	
    
    {* gestione dell'eccezione apostrofo su servizi e argomenti 
    {def $filterParameters      = getFilterParameters()
         $cleanFilterParameters = array()
         $tempFilter = false()}
    {foreach $filterParameters as $i => $f}
    {if $f|begins_with( 'subattr_servizio___name____s:' )}
        {set $tempFilter = $f|explode(":")}
        {set $cleanFilterParameters = $cleanFilterParameters|append( concat( 'subattr_servizio___name____s:', $tempFilter[1]|explode("_")|implode("'") ) )}
    {elseif $f|begins_with( 'subattr_argomento___name____s:' )}
        {set $tempFilter = $f|explode(":")}
        {set $cleanFilterParameters = $cleanFilterParameters|append( concat( 'subattr_argomento___name____s:', $tempFilter[1]|explode("_")|implode("'") ) )}
    {else}
        {set $cleanFilterParameters = $cleanFilterParameters|append( $f )}
    {/if}
    {/foreach}    
    {set $filterParameters = $cleanFilterParameters}*}

    {* gestione dell'eccezione apostrofo su servizi e argomenti *}
    {def $filterParameters      = getFilterParameters()
         $cleanFilterParameters = array()
         $tempFilter = false()}

    {foreach $filterParameters as $i => $f}
        {set $tempFilter = false()}
        {if $f|begins_with( 'subattr_' )}
            {set $tempFilter = $f|explode(":")}
            {set $cleanFilterParameters = $cleanFilterParameters|append( concat( $tempFilter[0], ':', $tempFilter[1]|explode("_")|implode("'") ) )}    
        {else}
            {set $cleanFilterParameters = $cleanFilterParameters|append( $f )}
        {/if}
    {/foreach}            
    {set $filterParameters = $cleanFilterParameters}
    
    {def $search_hash = hash(
                            'query', concat( $geoBoost, $search_text ),
                            'offset', $view_parameters.offset,
                            'subtree_array', $sub_tree,
                            'limit', $page_limit,
                            'sort_by', hash( $sort_by, $order_by ),
                            'facet', array( hash( 'field', 'class', 'name', 'Tipologia di contenuto', 'limit', 1000 ) ),
                            'filter', $filterParameters
                            )}

    {set $search            = fetch( ezfind, search, $search_hash )
         $search_text       = $memo_search_text
         $search_count      = $search['SearchCount']
         $search_result     = $search['SearchResult']
         $stop_word_array   = $search['StopWordArray']
         $search_data       = $search
    }
    
    {def $search_extras=$search['SearchExtras']}
    
    {if is_set( $search_extras.facet_fields.0.field )}
    	{def $facetField = $search_extras.facet_fields.0.field}
    {else}
	    {def $facetField = 'class'}
	{/if}
{/if}

{def $baseURI=concat( '/content/advancedsearch?SearchText=', $search_text )}

{def $uriSuffix = $filterParameters|getFilterUrlSuffix()}

{*if and( $from_attributes, $from_attributes|count()|gt(0) )}
    {foreach $from_attributes as $filter_name => $from_attribute}
        {if $from_attribute|ne( '' )}
            {set $uriSuffix = concat( $uriSuffix, '&from_attributes[', $filter_name, ']=', $from_attribute  )}
            {if and( $to_attributes, is_set( $to_attributes[$filter_name] ), $to_attributes[$filter_name]|ne( '' )  )}
                {set $uriSuffix = concat( $uriSuffix, '&to_attributes[', $filter_name, ']=', $to_attributes[$filter_name]  )}
            {/if}
        {/if}
    {/foreach}
{/if*}

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

               
	<div class="attribute-header"><h1>{"Search"|i18n("design/ezwebin/content/search")} 
	{if and( $sub_tree_name, $cerca_in_area_tematica|not )} 
		solo in "{$sub_tree_name}"
	{elseif and( $sub_tree_name, $cerca_in_area_tematica )} 
		nell'area tematica "{$sub_tree_name}"
	{else}
		in tutto il sito
	{/if}</h1></div>
	<fieldset>
		<legend class="hide">{"Search"|i18n("design/ezwebin/content/search")} {if $sub_tree_name} solo in "{$sub_tree_name}"{else} in tutto il sito{/if}</legend>

		<div class="border-box box-gray block-search">
		<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
		<div class="border-ml"><div class="border-mr"><div class="border-mc">
		<div class="border-content">

			<div class="content-search">
				<p>
					{*if is_set( $sub_tree[0] )}
                    <input name="SubTreeArray[]" type="hidden" value="{$sub_tree[0]}" />
                    {/if*}
					<label for="Search">Ricerca libera</label>
					<input class="halfbox" type="text" size="20" name="SearchText" id="Search" value="{$search_text|wash}" />
					<input class="defaultbutton" name="SearchButton" type="submit" value="{'Search'|i18n('design/ezwebin/content/search')}" />
            {def $link_istruzioni_ricerca = fetch('content','node',hash('node_id', ezini('LinkSpeciali', 'NodoIstruzioniRicerca', 'openpa.ini') ))}
                    <span style="padding-left: 400px; font-size: 0.9em;">Cerchi aiuto?
                    <a href={$link_istruzioni_ricerca.url_alias|ezurl()} 
                          	title="Guarda il video-guida su come sfruttare al massimo il motore di ricerca del sito">Impara ad usare la ricerca</a>
			</span>

{set-block variable=$block_advanced_container}

				<div class="block-search-advanced-container square-box-soft-gray-2">
					<div class="block-search-advanced-link">
						<p class="eztoggle" id="AdvancedSearch">Ricerca avanzata</p>

						<div class="block-search-advanced hide" id="AdvancedSearchPanel">					
							<label for="PhraseSearchText">{"Search the exact phrase"|i18n("design/standard/content/search")}</label>
							<input class="box" type="text" size="40" name="PhraseSearchText" id="PhraseSearchText" value="{$phrase_search_text|wash}" />

							<div class="columns-three">
							<div class="col-1-2">
							<div class="col-1">
							<div class="col-content">

                                {def $node_servizi_attivi           = fetch( content, node, hash( node_id, ezini( 'Servizi', 'attivi', 'openpa.ini') ) )
                                     $node_servizi_non_attivi       = fetch( content, node, hash( node_id, ezini( 'Servizi', 'non_attivi', 'openpa.ini') ) )
                                     $node_argomenti                = fetch( content, node, hash( node_id, ezini( 'Argomenti', 'argomenti', 'openpa.ini') ) )
                                     $servizi_attivi                = fetch( content, list, hash(
                                                                                                parent_node_id, $node_servizi_attivi.node_id,
                                                                                                'sort_by', array('name', true()),
                                                                                                'class_filter_type',  'include',
                                                                                                'class_filter_array', array( 'servizio'))
                                                                                                )
                                     $servizi_non_attivi            = fetch( content, list, hash(
                                                                                                parent_node_id, $node_servizi_non_attivi.node_id,
                                                                                                'sort_by', array('name', true()),
                                                                                                'class_filter_type',  'include',
                                                                                                'class_filter_array', array( 'servizio'))
                                                                                                )
                                     $margomenti                    = fetch( content, list, hash(
                                                                                                parent_node_id, $node_argomenti.node_id,
                                                                                                'sort_by', array('name', true()),
                                                                                                'class_filter_type',  'include',
                                                                                                'class_filter_array', array( 'macroargomento'))
                                                                                                )
                                }

								<div class="subfilter">
                                {set $filterParameter = getFilterParameter( solr_subfield('servizio','name','string') )}
									<label for="Servizi">Inerente al Servizio:</label>
									<select id="Servizi" name="filter[{solr_subfield('servizio','name','string')}]">
									<option value="">Qualsiasi servizio</option>
									<optgroup  label="{$node_servizi_attivi.name|wash}">
									   {foreach $servizi_attivi as $k => $servizio}
											   <option {if $filterParameter|contains( concat( '"', $servizio.name|wash|explode("'")|implode("_"), '"' )  )} class="marked" selected="selected" {/if} value='"{$servizio.name|wash|explode("'")|implode("_")}"'>{$servizio.name|wash}</option>
									   {/foreach}
									   </optgroup>
									   <optgroup  label="Servizi non attivi">
									   {foreach $servizi_non_attivi as $k => $servizio}
											   <option {if $filterParameter|contains( concat( '"', $servizio.name|wash|explode("'")|implode("_"), '"' )  )}  class="marked" selected="selected" {/if} value='"{$servizio.name|wash|explode("'")|implode("_")}"'>{$servizio.name|wash}</option>
									   {/foreach}
									   </optgroup>
									</select>
								</div>
			
								{*  BLOCCO FILTRO SEZIONE oggetto - INIZIO  *}
                                
								<div class="subfilter">
									<div class="element">
										<label for="SubTreeArray">Sezione del sito in cui cercare:</label>
										<select id="SubTreeArray" name="SubTreeArray[]">
											<option value="2">In tutte le sezioni</option>
										{set $subtree_node = false()}
										{foreach $select_sezioni as $subtree}
											{set $subtree_node=fetch(content,node,hash(node_id, $subtree))}
											{if is_set($subtree_node.name)}                                            
											<option {if and( count($SubTreeArray), $SubTreeArray|contains($subtree) )} class="marked" selected="selected"'{/if} value="{$subtree}">
												Solo in "{$subtree_node.name|wash}"
											</option>
											{/if}
										{/foreach}
										</select> 
									</div>
								</div>
								{* FINE BLOCCO FILTRO SEZIONE *}	

							</div>
							</div>
							<div class="col-2">
							<div class="col-content">
								<div class="subfilter">
                                {set $filterParameter = getFilterParameter( solr_subfield('argomento','name','string') )}
									<label for="Argomenti">Argomento</label>
									<select id="Argomenti" name="filter[{solr_subfield('argomento','name','string')}]">
										<option value="">Qualsiasi argomento</option>
										
										{foreach $margomenti as $k => $margomento}
										<optgroup  label="{$margomento.name|wash}">
											{set $argomenti_tutti = fetch( content, list, hash(  parent_node_id, $margomento.node_id,
                                                                                                'sort_by', array('name', true()),
                                                                                                'class_filter_type',  'include',
                                                                                                'class_filter_array', array( 'argomento' )
                                                                                            ))}
											{foreach $argomenti_tutti as $k => $argomento}
                                                <option {if $filterParameter|contains( concat( '"', $argomento.name|wash|explode("'")|implode("_"), '"' )  )}  class="marked" selected="selected" {/if} value='"{$argomento.name|wash|explode("'")|implode("_")}"'>{$argomento.name|wash}</option>
											{/foreach}
										</optgroup>
                                        {/foreach}
									</select>
								</div>

								<div class="subfilter">
									<label for="Sort">Ordina per</label>									
									<select id="Sort" name="Sort">
                                        <option value=""> - Seleziona</option>
										<option {if $Sort|eq('published')} class="marked" selected="selected"{/if} value="published">Data di pubblicazione</option>
										<option {if $Sort|eq('score')} class="marked" selected="selected"{/if} value="score">Rilevanza</option>
										<option {if $Sort|eq('class_name')} class="marked" selected="selected"{/if} value="class_name">Tipologia di contenuto</option>
										<option {if $Sort|eq('name')} class="marked" selected="selected"{/if} value="name">Nome</option>
									</select>
									<label for="Order">Ordinamento</label>
									<select {if $Order}class="marked"{/if} name="Order" id="Order">
										<option value=""> - Seleziona</option>
										<option {if $Order|eq('desc')} class="marked" selected="selected"{/if} value="desc">Discendente</option>
										<option {if $Order|eq('asc')} class="marked" selected="selected"{/if} value="asc">Ascendente</option>
									</select>
								</div>	

							</div>
							</div>
							</div>
							<div class="col-3">
							<div class="col-content">

								<div class="subfilter">
									<label for="anno_s">Anno</label>
									<select {if is_set($anno_s[0])}class="marked"{/if} id="anno_s" name="anno_s[]">
										<option value="">Qualsiasi anno</option>
										{foreach $_anni as $anno}
										<option {if is_set($anno_s[0])}{if $anno|eq($anno_s[0])} class="marked" selected="selected"{/if}{/if} value="{$anno}">{$anno}</option>
										{/foreach}
									</select>
								</div>
                                
                                <div class="block float-break">
                                    <div class="block">
                                        <span class="label">Data di pubblicazione:</span>
                                    </div>
                                    <div class="left">
                                        <label for="from" class="text-center">Dalla data: <small class="no-js-show"> (GG-MM-AAAA)</small>
                                        <input type="text" id="from" name="from" title="Dalla data" value="{if $from}{$from}{/if}" /></label>
                                    </div>
                                    <div class="right">
                                        <label for="to"  class="text-center">Alla data: <small class="no-js-show"> (GG-MM-AAAA)</small>
                                        <input id="to" type="text" name="to" title="Alla data" value="{if $to}{$to}{/if}" /></label>
                                    </div>
                                </div>
                                
                                <div class="block float-break">
                                    <div class="block">
                                        <span class="label">Usa condizioni logiche:</span>
                                    </div>
                                    <div class="left">
                                        <label for="radio_and" class="text-center">AND
                                        <input type="radio" id="radio_and" name="cond" title="AND" value="AND" {if $cond|eq('AND')}checked="checked"{/if} /></label>
                                    </div>
                                    <div class="right">
                                        <label for="radio_or"  class="text-center"> OR
                                        <input id="radio_or" type="radio" name="cond" title="OR" value="OR" {if $cond|ne('AND')}checked="checked"{/if} /></label>
                                    </div>
                                </div>

							</div>
							</div>
							</div>
                            <div class="block">
							<input class="defaultbutton" name="SearchButton" type="submit" value="{'Search'|i18n('design/ezwebin/content/search')}" />
                            </div>
						</div>						
					</div>		
				</div>

{/set-block}

{$block_advanced_container}

{set-block variable=$block_search_filter}
				{if and( $SearchButton, $search_count, is_set($search_extras.facet_fields.0.nameList) )}
                {set $filterParameter = getFilterParameter( 'contentclass_id' )}
				<div class="block-search-advanced-container square-box-soft-gray-2">
					<div class="block-search-advanced-link">
						<p class="notoggle open" id="FilterSearch">
						{if $filterParameter|count()|gt(0)}
							Stai filtrando per:
							{def $stai_filtrando_per="checked='checked'"}
						{else}
							{def $stai_filtrando_per=false()}
							Restringi la ricerca solo a:
						{/if}
						</p>
					

						<div id="FilterSearchPanel">
						<p class="ezjs_toggleCheckboxes no-js-hide" title="Inverti la selezione" >Attiva o disattiva i filtri</p>			
						<div class="filter-container float-break">
						{def $faccette=$search_extras.facet_fields.0.nameList}
						{set $faccette=$faccette|asort()}
						{foreach $faccette as $facetID => $name}
							{if $not_available_facets|contains($facetID)|not()}
							   <label>
								<input value="{$search_extras.facet_fields.0.queryLimit[$facetID]|wash}" 
								       title="{$name|wash}" name="filter[]" type="checkbox" {$stai_filtrando_per} />
								{$name|wash} ({$search_extras.facet_fields.0.countList[$facetID]})
							   </label>
							   
							{/if}
						{/foreach}
						</div>
						<input class="defaultbutton" name="SearchButton" type="submit" value="{'Search'|i18n('design/ezwebin/content/search')}" />
					</div>						
					</div>
				</div>
				{/if}
{/set-block}

			</div>
		</div>
		</div></div></div>
		<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>					
		</div>
	</fieldset>
{/if}


{* FORSE CERCAVI... *}

{if $search_extras.spellcheck_collation}
	{def $spell_url=concat('content/advancedsearch/',$search_text|count_chars()|gt(0)|choose('',concat('?SearchText=',$search_extras.spellcheck_collation|urlencode)))|ezurl}
	<p>Forse intendevi cercare per <b>{concat("<a href='",$spell_url,"'>")}{$search_extras.spellcheck_collation}</a></b> ?</p>
{/if}

{* PAROLE ESCLUSE *}
{if $stop_word_array}
    <p>
    {"The following words were excluded from the search"|i18n("design/base")}:
    {foreach $stop_word_array as $stopWord}
        {$stopWord.word|wash}
        {delimiter}, {/delimiter}
    {/foreach}
    </p>
{/if}


{if $SearchButton}
	{switch name=Sw match=$search_count}
		{case match=0}
			<div class="warning">
				{if $search_text|ne('')}
                    <h2>{'No results were found when searching for "%1".'|i18n("design/ezwebin/content/search",,array($search_text|wash))}</h2>
                    {if $search_extras.hasError}{$search_extras.error|wash}{/if}				
                    <p>{'Search tips'|i18n('design/ezwebin/content/search')}</p>
                    <ul>
                        <li>{'Check spelling of keywords.'|i18n('design/ezwebin/content/search')}</li>
                        <li>{'Try changing some keywords (eg, "car" instead of "cars").'|i18n('design/ezwebin/content/search')}</li>
                        <li>{'Try searching with less specific keywords.'|i18n('design/ezwebin/content/search')}</li>
                        <li>{'Reduce number of keywords to get more results.'|i18n('design/ezwebin/content/search')}</li>
                    </ul>
                {else}
                    <h2>Nessun risultato ottenuto</h2>
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
                        <h2>{'Search for "%1" returned %2 matches'|i18n("design/ezwebin/content/search",,array($search_text|wash,$search_count))}</h2>
                    {else}
                        <h2>La ricerca ha prodotto {$search_count} risultati</h2>
                    {/if}
                    </div>
                    {include uri='design:parts/openpa/line_controls.tpl'}
		{/case}
	{/switch}

	{if $search_result|count()}

    {def $sort_url = concat( '?SearchText=',$search_text|urlencode,
                             '&PhraseSearchText=',$phrase_search_text|urlencode,
                             $search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)),
                             $uriSuffix,
                             "&SearchButton=Cerca",
                             cond( and( is_set($anno_s), is_set($anno_s[0]) ), concat( "&anno_s[]=",$anno_s[0] ) ),
                             cond( is_set( $sub_tree[0] ), concat( "&SubTreeArray[]=",$sub_tree[0] ) ),
                             "&cond=",$cond,
                             "&from=",$from,
                             "&to=",$to )}
    
	<table class="list advanced_search" cellspacing="0" cellpadding="0" border="0" summary="Risultati della ricerca">
		<thead>
			<tr>
			{if $ClassFilter|count()|ne(1)}<th class="width-1">Tipologia</th>{/if}
			<th>                
				<div class="sort-label">
                    Risultato della ricerca
                </div>
                <div class="sort-icons">
                    <a href={concat( $sort_url,"&Sort=", $sort_default, "&Order=asc" )} class="sort-icon sort-icon-asc {if and( $sort_by|eq( $sort_default ), $order_by|eq( 'asc' ) )}selected{/if}">Ordina risultati con ordinamento ascendente</a>
                    <a href={concat( $sort_url,"&Sort=", $sort_default, "&Order=desc" )} class="sort-icon sort-icon-desc {if and( $sort_by|eq( $sort_default ), $order_by|eq( 'desc' ) )}selected{/if}">Ordina risultati con ordinamento discendente</a>
                </div>
            </th>
			<th>
                <div class="sort-label">
                    Data
                </div>
                <div class="sort-icons">
                    <a href={concat( $sort_url,"&Sort=published&Order=asc" )} class="sort-icon sort-icon-asc {if and( $sort_by|eq( 'published' ), $order_by|eq( 'asc' ) )}selected{/if}">Ordina risultati per data con ordinamento ascendente</a>
                    <a href={concat( $sort_url,"&Sort=published&Order=desc" )} class="sort-icon sort-icon-desc {if and( $sort_by|eq( 'published' ), $order_by|eq( 'desc' ) )}selected{/if}">Ordina risultati per data con ordinamento discendente</a>
                </div>
            </th>
			</tr>
		</thead>
		<tbody>
		{foreach $search_result as $result sequence array(bglight,bgdark) as $bgColor}
		   {node_view_gui view=ezfind_line sequence=$bgColor content_node=$result show_class=$ClassFilter|count()|ne(1)}
		{/foreach}
		<tr>
			<td colspan="5">
			{include name=Navigator
				 uri='design:navigator/google.tpl'
				 page_uri='content/advancedsearch'
				 page_uri_suffix=concat( '?SearchText=',$search_text|urlencode,'&PhraseSearchText=',$phrase_search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)), $uriSuffix,"&SearchButton=Cerca",cond( is_set($anno_s[0]), concat("&anno_s[]=",$anno_s[0]) ),cond( is_set( $sub_tree[0] ), concat( "&SubTreeArray[]=",$sub_tree[0] ) ),"&Sort=",$Sort,"&Order=",$Order,"&cond=",$cond,"&from=",$from,"&to=",$to )
				 item_count=$search_count
				 view_parameters=$view_parameters
				 item_limit=$page_limit}
			{/if}		 
			</td>
		</tr>
		</tbody>
	</table>
	{/if} {* chiudi SearchButton*}
                            </div>
                        </div>

                </div></div></div>
                <div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
                </div>
            </div>
        </div>

        <div class="extrainfo-column-position">
  		
            <div class="extrainfo-column">
                {$block_embed_searchbox}
                
                {if is_set($block_search_filter)}
                <div class="border-box">
                <div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
                <div class="border-ml"><div class="border-mr"><div class="border-mc float-break">
					{$block_search_filter}
                </div></div></div>
                <div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>
</form>	



{ezscript_require(array( 'ezjsc::jquery', 'ezjsc::jqueryio', 'ui-widgets.js', 'ui-datepicker-it.js') )}
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
