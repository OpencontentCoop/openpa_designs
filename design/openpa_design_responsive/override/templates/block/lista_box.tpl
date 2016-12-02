{*
	Vista blocco simile a numerini che però visualizza uno sotto l'altro gli elementi
	Questa vista ammette UNICAMENTE OGGETTI DI TIPO AVVISO, per aggiungere altri tipi di oggetti implementare l'array $class_filter
*}

{def $customs=$block.custom_attributes
     $errors=false()
     $sort_array=array()
     $classes=array()
     $classi_senza_data_inline = openpaini( 'GestioneClassi', 'classi_senza_data_inline', array())
     $classi_con_data_inline = openpaini( 'GestioneClassi', 'classi_con_data_inline', array())
     $classi_blocco_particolari = openpaini( 'GestioneClassi', 'classi_blocco_particolari', array())
     $classi_senza_correlazioni_inline = openpaini( 'GestioneClassi', 'classi_senza_correlazioni_inline', array())
     $attributes_to_show=array('organo_competente', 'circoscrizione')
     $attributes_with_title=array('servizio','argomento')
     $curr_ts = currentdate()
}

{if $customs.limite|gt(0)}
    {def $limit=$customs.limite}
{else}
    {def $limit=10}
{/if}

{if $customs.livello_profondita|eq('')}
    {def $depth=10}
{else}
    {def $depth=$customs.livello_profondita}
{/if}

{def $nodo=fetch(content,node,hash(node_id,$customs.node_id))}

{switch match=$customs.ordinamento}
{case match=''}
    {set $sort_array=$nodo.sort_array}
{/case}
{case match='priorita'}
    {set $sort_array=array('priority', true())}
{/case}
{case match='pubblicato'}
    {set $sort_array=array('published', false())}
{/case}
{case match='modificato'}
    {set $sort_array=array('modified', false())}
{/case}
{case match='nome'}
    {set $sort_array=array('name', true())}
{/case}
{/switch}

{if $customs.escludi_classi|ne('')}
    {set $classes=$customs.escludi_classi|explode(',')}
    {set $classes = merge($classes, openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow', array())) }
        {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                        'class_filter_type', 'exclude',
                                                        'class_filter_array', $classes,
                                                        'depth', $depth,
                                                        'limit', $limit,
                                                        'sort_by', $sort_array) )}
{elseif $customs.includi_classi|ne('')}
    {set $classes=$customs.includi_classi|explode(',')}

    {if $customs.includi_classi|ne('news')}
         {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                            'class_filter_type', 'include', 'class_filter_array', $classes,
                            'depth', $depth, 'limit', $limit, 'sort_by', $sort_array) )}
    {else}
        {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                        'attribute_filter', array( 'and',
                                                             array( 'news/data_inizio_pubblicazione_news', '<=', $curr_ts  ),
                                                             array( 'news/data_fine_pubblicazione_news', '>=', $curr_ts  )),
                                                        'class_filter_type', 'include', 'class_filter_array', array('news'),
                                                        'depth', $depth,
                                                        'limit', $limit,
                                                        'sort_by', array('published', false())) )}
    {/if}
{else}
    {set $classes = openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow', array())}
        {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                        'class_filter_type', 'exclude',
                                                        'class_filter_array', $classes,
                                                        'depth', $depth,
                                                        'limit', $limit,
                                                        'sort_by', $sort_array) )}
{/if}


<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">

	{if $block.name}
		<h2 class="block-title">
		<a href={$nodo.url_alias|ezurl()} title="Vai a {$block.name|wash()}">{$block.name}</a>
		</h2>
	{/if}

     {foreach $children as $index => $child}
        <div class="list">
        {include uri='design:block_item/list-item.tpl' name=lista-num node=$child show_title=true()}
        </div>
    {/foreach}
    
</div>