{*
	Oggetti correlati a partire da un elenco

	node			nodo di riferimento
	title			titolo del blocco
	oggetti_correlati	array di class_indentifier
	visualizzazione		'estesa' oppure non popolato
*}

{def $sezioni_per_tutti= openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array())
     $has_content = false()}

{if is_set( $view )|not()}
    {def $view = 'classificazione'}
{/if}

{if and( $oggetti_correlati|count()|gt(0), $title|eq('Informazioni correlate:') )}

    {set-block variable=correlati}
    		 
    {foreach $oggetti_correlati as $oggetto_correlato}
        {def $classi_attributi = wrap_user_func('getClassAttributes', array(array($oggetto_correlato)) )
             $classe_attributo = false()}             
        {foreach $classi_attributi as $ca}
            {if $ca.identifier|eq($node.object.class_identifier)}
                    {set $classe_attributo = true() }
            {/if}
        {/foreach}        
        {if $classe_attributo}
            {def $res_fetch=fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id, 'attribute_identifier', concat( $node.object.class_identifier,'/',$oggetto_correlato) ) ) }
        {else}
            {def $res_fetch = array()}
        {/if}        
        {if $res_fetch|count()|gt(0)}                        
            <div class="table-responsive">
            <table class="table table-compressed table-striped advanced_search" cellspacing="0" cellpadding="0" border="0">
                <thead>
                    <tr>
                    <th>Contenuto</th>
                    <th>Data</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $res_fetch as $valore}
                    {if $valore.can_read}
                        {set $has_content=true()}                
                        {node_view_gui content_node=$valore.main_node view=ezfind_advanced_line}
                    {/if}
                {/foreach}
                </tbody>
            </table>
            </div>
        {/if}
        {undef $res_fetch $classi_attributi $classe_attributo}
    {/foreach}
    {/set-block}


    {if $has_content}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h2>{$title}</h2>
            </div>
            {$correlati}
        </div>
    {/if}
    {undef $has_content}

{/if}
