{def $valid_node = $block.valid_nodes[0]}
<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
	{if $block.name}
		<h2 class="block-title">			
			{$block.name}			
		</h2>
	{/if}
		
	<div id="{$valid_node.name|slugize()}" class="border-box box-gray box-accordion ui-accordion-header {if $index|eq(0)}no-js-ui-state-active{/if}">
        <h4>
            {if $valid_node.class_identifier|eq('link')}
                <a href={$valid_node.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">{$valid_node.name|wash()}</a>
            {elseif is_set($valid_node.data_map.testo_news)}
                <a{if $index|eq(0)} class="active"{/if} href={$valid_node.parent.url_alias|ezurl()}>{$valid_node.parent.name|wash()}</a>
            {else}
                <a{if $index|eq(0)} class="active"{/if} href={$valid_node.url_alias|ezurl()}>{$valid_node.name|wash()}</a>
            {/if}
        </h4>
    </div>
    
    <div id="{$valid_node.name|slugize()}-detail" class="border-box box-gray box-accordion ui-accordion-content {if $index|eq(0)}ui-accordion-content-active{/if} {if $index|gt(0)}no-js-hide{/if}">
        {include uri='design:block_item/list-item.tpl' name=lista-accordion node=$valid_node show_title=false()}	
    </div>
</div>    
