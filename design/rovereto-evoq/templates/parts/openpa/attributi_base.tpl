{def $attributi_da_escludere = openpaini( 'GestioneAttributi', 'attributi_da_escludere' )
     $oggetti_senza_label = openpaini( 'GestioneAttributi', 'oggetti_senza_label' )
     $attributi_senza_link = openpaini( 'GestioneAttributi', 'attributi_senza_link' )
     $attributi_da_evidenziare = openpaini( 'GestioneAttributi', 'attributi_da_evidenziare' )}

{if is_set($node)}
    {if is_set( $node.data_map.oggetto )}
        {set $attributi_da_escludere = $attributi_da_escludere|append( 'oggetto' )}
    {elseif and( is_set( $node.data_map.abstract ), $node.data_map.abstract.has_content )}
        {set $attributi_da_escludere = $attributi_da_escludere|append( 'abstract' )}
    {elseif and( is_set( $node.data_map.short_description ), $node.data_map.short_description.has_content )}
        {set $attributi_da_escludere = $attributi_da_escludere|append( 'short_description' )}
    {/if}
{/if}

{def $must_close_div = false()}

{if is_set( $contentobject_attributes )|not()}
    {def $contentobject_attributes = $node.object.contentobject_attributes}
    <div class="attributi-base">
    {set $must_close_div = true()}    
{/if}


    {foreach $contentobject_attributes as $attribute}
		
        {if and( $attribute.has_content, $attribute.content|ne('0') )}
		
        	{if $attributi_da_escludere|contains( $attribute.contentclass_attribute_identifier )|not()}
                
                {if and( flip_exists( $attribute.contentobject_id, $attribute.version ), $attribute.contentclass_attribute_identifier|eq( 'file' ) )}
                    {set $oggetti_senza_label = $oggetti_senza_label|append( $attribute.contentclass_attribute_identifier )}
                {/if}
				
				
                {if $oggetti_senza_label|contains( $attribute.contentclass_attribute_identifier )|not()}
				   <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
						<div class="col-md-3 attribute-label">{$attribute.contentclass_attribute_name}</div>
						<div class="col-md-9">
							{if $attributi_senza_link|contains( $attribute.contentclass_attribute_identifier )}
								{attribute_view_gui href='nolink' attribute=$attribute}
							{else}
								{attribute_view_gui attribute=$attribute}
							{/if}
						</div>
				   </div>
				{else}
				   <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
					<div class="col-md-12">
						{if $attributi_senza_link|contains( $attribute.contentclass_attribute_identifier )}
							{attribute_view_gui href='nolink' attribute=$attribute show_flip=true()}
						{else}
							{attribute_view_gui attribute=$attribute show_flip=true()}
						{/if}
					</div>
				   </div>
				{/if}
			{/if} 
		{else}
			{if $attribute.contentclass_attribute_identifier|eq('ezflowmedia')}				
                <div class="row attribute-fullbase-{$attribute.contentclass_attribute_identifier}">
                    <div class="col-md-12">
                    {attribute_view_gui attribute=$attribute}
                    </div>
                </div>
			{/if}		
		{/if}
	{/foreach}

{if $must_close_div}
</div>
{/if}