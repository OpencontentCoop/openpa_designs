{*
	OGGETTI INVERSAMENTE CORRELATI
	node	nodo a cui si riferisce
	title	titolo del blocco
	classe	classe su cui filtrare la ricerca
	attrib	attribute su cui filtrare la ricerca
	href	se =nolink non fa vedere il link all'oggetto inversamente correlato
	

*}

{if $classe|eq("struttura")}
	{def $sortby = array( 'class_identifier', true() )}
{else}
	{def $sortby = array( 'name', true() )}
{/if}


{def $search_hash = hash( 'limit', 100,
                          'class_id', array( $classe ),                        
                          'filter', array( concat( solr_meta_subfield($attrib,'id'),':', $node.object.id ) ) )
     $search = fetch( ezfind, search, $search_hash )
     $objects_count = $search.SearchCount
     $objects = $search.SearchResult}

{if $objects_count|gt(0)}

    <div class="panel panel-default">
        <div class="panel-heading">
            <h2>{$title}</h2>
        </div>
        <table class="table">
        {foreach $objects as $object}
            <tr><td>
                {if $classe|eq('ruolo')}
                    {$object.name}
                      
                    {if $object.data_map.descrizione_ruolo_speciale.has_content}
                        {attribute_view_gui attribute=$object.data_map.descrizione_ruolo_speciale}
                    {else}
                        presso {attribute_view_gui attribute=$object.data_map.struttura_di_riferimento}
                    {/if}
                
                {elseif $classe|eq('struttura')} 
                    {set $my_node=fetch( 'content', 'node', hash( 'node_id', $object.data_map.tipo_struttura.content.relation_list[0].node_id) )}								   
                       <a href={$object.url_alias|ezurl()}>{$my_node.name|wash()} "{$object.name}"</a>	
                
                {elseif and( is_set($href), $href|eq("nolink") )}
                    {$object.name}
                
                {else}
                    {node_view_gui content_node=$object view='simplified_line'}
                
                {/if}

            </td></tr>
        {/foreach}
        </table>
    </div>
	

{elseif $classe|eq('ruolo')}

    {set $search_hash = hash( 'limit', 100,
                              'class_id', array( 'area', 'servizio', 'ufficio', 'struttura' ),                        
                              'filter', array( concat( solr_meta_subfield('responsabile','id'),':', $node.object.id ) ) )
         $search = fetch( ezfind, search, $search_hash )
         $objects_count = $search.SearchCount
         $objects = $search.SearchResult}
     
    {if $objects_count|gt(0)}

		<div class="panel panel-default">
            <div class="panel-heading">
                <h2>{$title}</h2>
            </div>
            <table class="table">
            {foreach $objects as $object}
                <tr><td>
                    Responsabile di <a href={$object.url_alias|ezurl} title="Link a {$object.name|wash()}">{$object.name|wash()}</a>
                </td></tr>
            {/foreach}
			</table>
        </div>
	
	{/if}

{/if}

{*

{set $search_hash = hash( 'limit', 100,
                              'class_id', array( 'area', 'servizio', 'ufficio', 'struttura', 'organo_politico' ),                        
                              'filter', array( 'or',
                                               concat( 'submeta_responsabile___id_si:', $node.object.id ) )
                                               concat( 'submeta_vicepresidente___id_si:', $node.object.id ) )
                                               concat( 'submeta_presidente___id_si:', $node.object.id ) )
                                             )
         $search = fetch( ezfind, search, $search_hash )
         $objects_count = $search.SearchCount
         $objects = $search.SearchResult}
     
    {if $objects_count|gt(0)}

		<div class="panel panel-default">
            <div class="panel-heading">
                <h2>{$title}</h2>
            </div>
            <table class="table">
            {foreach $objects as $object}
                <tr><td>
                {if array('area', 'servizio', 'ufficio', 'struttura')|contains( $object.class_identifier )}
                    Responsabile di 
                {else}
                    {def $done = false()}
                    {foreach $object.data_map.presidente.content.relation_list as $relation}
                        {if $relation.contentobject_id|eq($node.object.id)}
                            Presidente di 
                            {set $done = true()}
                            {break}
                        {/if}
                    {/foreach}
                    {if $done|eq(false())}
                        {foreach $object.data_map.vicepresidente.content.relation_list as $relation}
                            {if $relation.contentobject_id|eq($node.object.id)}
                                Vicepresidente di 
                                {set $done = true()}
                                {break}
                            {/if}
                        {/foreach}
                    {/if}
                {/if}
                <a href={$object.url_alias|ezurl} title="Link a {$object.name|wash()}">{$object.name|wash()}</a>
                </td></tr>
            {/foreach}
			</table>
        </div>
	
	{/if}

*}

