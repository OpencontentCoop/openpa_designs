{def $customs=$block.custom_attributes $errors=false()
     $sort_array=array() 
     $classes=array()     
     $classi_blocco_particolari = openpaini( 'GestioneClassi', 'classi_blocco_particolari', array())
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

{def $custom_node = fetch( 'content', 'node', hash( 'node_id', $customs.node_id ))}

{if $custom_node}
    
    {switch match=$customs.ordinamento}
        {case match=''}
            {set $sort_array=$custom_node.sort_array}
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
        {case}{/case}
    {/switch}
    
    {* se la sorgente è virtualizzata restituisce i risultati della virtualizzazione *}
    {if and( is_set( $custom_node.data_map.classi_filtro ), $custom_node.data_map.classi_filtro.has_content )}        
        {set $classes = $custom_node.data_map.classi_filtro.content|explode(',')}
        {def $virtual_classes = array()
             $virtual_subtree = array()}
        {foreach $classes as $class}
            {set $virtual_classes = $virtual_classes|append( $class|trim() )}
        {/foreach}
        {if $custom_node.data_map.subfolders.has_content}
            {foreach $custom_node.data_map.subfolders.content.relation_list as $relation}
                {set $virtual_subtree = $virtual_subtree|append( $relation.node_id )}
            {/foreach}
        {else}
            {set $virtual_subtree = array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
        {/if}
        
        {switch match=$customs.ordinamento}
        {case match='priorita'}
            {set $sort_array=hash('priority', 'asc')}
        {/case}
        {case match='pubblicato'}
            {set $sort_array=hash('published', 'desc' )}
        {/case}
        {case match='modificato'}
            {set $sort_array=hash('modified', 'desc')}
        {/case}
        {case match='nome'}
            {set $sort_array=hash('name', 'asc')}
        {/case}            
        {case}
            {set $sort_array=hash('published', 'desc' )}
        {/case}
        {/switch}
        
        {def $search_hash = hash( 'subtree_array', $virtual_subtree,                                  
                                  'limit', $limit,
                                  'class_id', $virtual_classes,
                                  'sort_by', $sort_array
                                  )
             $search = fetch( ezfind, search, $search_hash )             
             $children_count = $search['SearchCount']}
    {/if}
    
    {if and( is_set( $children_count ), $children_count|gt(0) )}
        {def $children = $search['SearchResult']}
    {elseif $customs.escludi_classi|ne('')}
        {set $classes=$customs.escludi_classi|explode(',')}
        {set $classes = merge($classes, openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow' )) }
        {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                        'class_filter_type', 'exclude',
                                                        'class_filter_array', $classes,
                                                        'depth', $depth,
                                                        'limit', $limit,
                                                        'sort_by', $sort_array) )}
    {elseif $customs.includi_classi|ne('')}
        {if $customs.includi_classi|eq('news')}
            {set $classes=$customs.includi_classi|explode(',')}
            {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                            'attribute_filter', array( 'and',
                                                                array( 'news/data_inizio_pubblicazione_news', '<=', $curr_ts ),
                                                                array( 'news/data_fine_pubblicazione_news', '>=', $curr_ts  ) ),
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $classes,
                                                            'depth', $depth,
                                                            'limit', $limit,
                                                            'sort_by', $sort_array) )}
             
        {else} 
            {set $classes=$customs.includi_classi|explode(',')}
            {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', $classes,
                                                            'depth', $depth,
                                                            'limit', $limit,
                                                            'sort_by', $sort_array) )}
        {/if}
    {else}
        {set $classes = openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow' )}
        {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                        'class_filter_type', 'exclude',
                                                        'class_filter_array', $classes,
                                                        'depth', $depth,
                                                        'limit', $limit,
                                                        'sort_by', $sort_array) )}
    {/if}
    
        
<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
    
    {ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js' ) )}
    
    <script type="text/javascript">
    {literal}
    $(function() {
    $("#{/literal}x{$block.id}{literal}").tabs({autoHeight:true}).tabs("rotate", 4000);
    var rotation = true;
    $(".rotation-control").bind('click', function() {
        if (rotation){
            $(this).parent().tabs("rotate", 0);
            rotation = false;
            $(this).removeClass('started');
            $(this).addClass('stopped');
        }else{
            $(this).parent().tabs("rotate", 4000);
            rotation = true;
            $(this).removeClass('stopped');
            $(this).addClass('started');
        }
    });
    });
    {/literal}
    </script>
    
    {if $block.name}
    <h2>
        <a href={$custom_node.url_alias|ezurl()} title="Vai a {$block.name|wash()}">{$block.name}</a>
    </h2>
    {/if}

    <div id="x{$block.id}" class="ui-tabs">	
        
        <ul class="list-inline">						 
            {foreach $children as $index => $child}
                <li><a href="#el{$block.id}-{$child.name|slugize()}-{$child.node_id}">{$index|inc()}</a></li>
            {/foreach}
        </ul>	
               
        {foreach $children as $index => $child}
        <div id="el{$block.id}-{$child.name|slugize()}-{$child.node_id}" class="{if $index|ge(3)}no-js-hide {/if}ui-tabs-hide">
            {include uri='design:block_item/list-item.tpl' name=lista-num node=$child show_title=true()}
        </div>
        {/foreach}
    </div>
</div>
{else}
<div class="warning">Errore: non &grave; selezionato un nodo sorgente.</div>
{/if}