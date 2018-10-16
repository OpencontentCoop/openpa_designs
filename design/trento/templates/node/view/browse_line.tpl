{*?template charset=utf-8?*}
{*
	TEMPLATE LINE BROWSE
	mode	modalita' in cui visualizzare i link
*}
{def 	
 	$attributes_to_show=array('organo_competente','abstract','test_news','intro','oggetto','location')
	$attributes_with_title=array('data_efficacia','servizio','incarico','competenza','argomento')
}

 <div class="class-documento">
	<div class="blocco-titolo-oggetto">    
 		<div class="titolo-blocco-titolo">
            {if is_set( $node.is_container )}
                <a href="{concat('content/browse/',$node.node_id)|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
            {else}
                {$node.name|wash()}
            {/if}
		</div>
		{foreach $node.data_map as $attribute}
        {if $attribute.has_content}
			{if $attributes_with_title|contains($attribute.contentclass_attribute_identifier)}
				<strong>{$attribute.contentclass_attribute_name}: </strong>{attribute_view_gui  href='nolink' attribute=$attribute}
			{/if}
			{if $attributes_to_show|contains($attribute.contentclass_attribute_identifier)}
				{attribute_view_gui href='nolink' attribute=$attribute}
			{/if}
		{/if}
		{/foreach}
	</div>
 </div>
 <div class="break"></div>
