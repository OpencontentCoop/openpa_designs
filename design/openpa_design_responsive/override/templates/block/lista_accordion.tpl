{def $customs=$block.custom_attributes $errors=false() $sort_array=array() $classes=array()}

{if $customs.limite|gt(0)}
    {def $limit=$customs.limite}
{else}
    {def $limit=3}
{/if}

{if $customs.livello_profondita|eq('')}
    {def $depth=10}
{else}
    {def $depth=$customs.livello_profondita}
{/if}

{def $nodo=fetch(content,node,hash(node_id,$customs.node_id))}

{if $nodo}

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

{if is_set($customs.escludi_classi)|not()}
    {set $customs = $customs|merge(hash('escludi_classi', ''))}
{/if}

{if is_set($customs.includi_classi)|not()}
    {set $customs = $customs|merge(hash('includi_classi', ''))}
{/if}

{if $customs.escludi_classi|ne('')}
    {set $classes=$customs.escludi_classi|explode(',')}
    {set $classes = merge($classes, openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow', array())) }
    {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                            'class_filter_type', 'exclude', 'class_filter_array', $classes,
                            'depth', $depth, 'limit', $limit, 'sort_by', $sort_array) )}
{elseif $customs.includi_classi|ne('')}
    {set $classes=$customs.includi_classi|explode(',')}
    {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                            'class_filter_type', 'include', 'class_filter_array', $classes,
                            'depth', $depth, 'limit', $limit, 'sort_by', $sort_array) )}
{else}
    {set $classes = openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow', array())}
    {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                            'class_filter_type', 'exclude', 'class_filter_array', $classes,
                            'depth', $depth, 'limit', $limit, 'sort_by', $sort_array) )}
{/if}


{ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js' ) )}

<script type="text/javascript">
{literal}
$(function() {
	$("#{/literal}{$nodo.name|slugize()}-{$block.id}{literal}").accordion({ 
		autoHeight: false,
		change: function(event, ui) { 
			$('a', ui.newHeader ).addClass('active'); 
			$('a', ui.oldHeader ).removeClass('active');  
		}
	}); 
});
{/literal}
</script>

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">

	{if $block.name}
		<h2>
			<a href={$nodo.url_alias|ezurl()} title="Vai a {$block.name|wash()}">{$block.name}</a>
		</h2>
	{/if}
	
	<div id="{$nodo.name|slugize()}-{$block.id}" class="ui-accordion">	
	
    {foreach $children as $index => $child}
		
		<div id="{$child.name|slugize()}" class="border-box box-gray box-accordion ui-accordion-header {if $index|eq(0)}no-js-ui-state-active{/if}">
            <h4>
                {if $child.class_identifier|eq('link')}
                    <a href={$child.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">{$child.name|wash()}</a>
                {elseif is_set($child.data_map.testo_news)}
                    <a{if $index|eq(0)} class="active"{/if} href={$child.parent.url_alias|ezurl()}>{$child.parent.name|wash()}</a>
                {else}
                    <a{if $index|eq(0)} class="active"{/if} href={$child.url_alias|ezurl()}>{$child.name|wash()}</a>
                {/if}
            </h4>
		</div>
		
		<div id="{$child.name|slugize()}-detail" class="border-box box-gray box-accordion ui-accordion-content {if $index|eq(0)}ui-accordion-content-active{/if} {if $index|gt(0)}no-js-hide{/if}">
            {include uri='design:block_item/list-item.tpl' name=lista-accordion node=$child show_title=false()}
            <p class="link">
                <a href={$child.url_alias|ezurl()} title="{$child.name|wash()}">
                    Vai a {$child.name|wash()}
                    <span class="glyphicon glyphicon-circle-arrow-right"></span>
                </a>
            </p>
		</div>
		
    {/foreach}
		
	</div>
	
</div>
{else}
    <div class="message-warning">Il nodo {$customs.node_id} non esiste</div>
{/if}