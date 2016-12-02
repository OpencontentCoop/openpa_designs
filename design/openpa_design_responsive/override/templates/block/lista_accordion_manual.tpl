{def $children                  = $block.valid_nodes
     $nodo                  	= $children[0]
     $classi_senza_data_inline 	= openpaini( 'GestioneClassi', 'classi_senza_data_inline', array())
     $classi_con_data_inline 	= openpaini( 'GestioneClassi', 'classi_con_data_inline', array())
}

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

<div class="ezpage-block lista_accordion {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">

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