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

{if $oggetti_correlati|count()|gt(0)}

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
            <tr>
                <th>{$res_fetch[0].class_name}</th>
                <td>
                {foreach $res_fetch as $valore}
                    {if $valore.can_read}
                        {set $has_content=true()}                
                        {node_view_gui content_node=$valore.main_node view=$view show_image='nessuna'}                        
                    {/if}
                {/foreach}
                </td>
            </tr>
        {/if}
        {undef $res_fetch $classi_attributi $classe_attributo}
    {/foreach}
    {/set-block}


    {if $has_content}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h2>{$title}</h2>
            </div>
            <table class="table">
                {$correlati}
            </table>
        </div>
    {/if}
    {undef $has_content}

{/if}
