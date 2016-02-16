{*
	OGGETTI INVERSAMENTE CORRELATI AS TEXT (mette il risultato come testo senza blocco)
	node	nodo a cui si riferisce
	title	titolo del blocco
	classe	classe su cui filtrare la ricerca
	attrib	attribute su cui filtrare la ricerca
	href	se =nolink non fa vedere il link all'oggetto inversamente correlato
	

*}
{def $search_hash = hash( 'limit', 100,
                          'class_id', array( $classe ),                        
                          'filter', array( concat( solr_meta_subfield($attrib,'id'),':', $node.object.id ) ) )
     $search = fetch( ezfind, search, $search_hash )
     $objects_count = $search.SearchCount
     $objects = $search.SearchResult}

{if $objects_count|gt(0)}	
    <p>
    {foreach $objects as $object}
        {if $object.can_read}
            {if $classe|eq('ruolo')}
                {$object.name}
                {if and( is_set( $object.data_map.struttura_di_riferimento ), $object.data_map.struttura_di_riferimento.has_content )}
                    presso {attribute_view_gui href=nolink attribute=$object.data_map.struttura_di_riferimento}
                {/if}
            {elseif $classe|eq('struttura')}                 
                <a href={$object.main_node.url_alias|ezurl()}>{$object.name|wash()} "{$object.name}"</a>	
            {elseif $href|eq("nolink")}
                {$object.name}
            {else}
                <a href={$object.url_alias|ezurl()}>{$object.name}</a>
            {/if}            
        {/if}
        {delimiter}, {/delimiter}
    {/foreach}
    </p>

{elseif $classe|eq('ruolo')}

    {set $search_hash = hash( 'limit', 100,
                              'class_id', array( 'area', 'servizio', 'ufficio', 'struttura' ),                        
                              'filter', array( concat( solr_meta_subfield('responsabile','id'),':', $node.object.id ) ) )
         $search = fetch( ezfind, search, $search_hash )
         $objects_count = $search.SearchCount
         $objects = $search.SearchResult}
         
    {if $objects_count|gt(0)}

        <p>
            {foreach $objects as $object}
                Responsabile di <a href={$object.url_alias|ezurl} title="Link a {$object.name|wash()}">{$object.name|wash()}</a>
                {delimiter}, {/delimiter}
            {/foreach}
        </p>
    
    {/if}

{/if}

