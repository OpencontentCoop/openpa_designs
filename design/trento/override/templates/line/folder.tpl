{* Folder - Line view *}

{def $classi_con_immagine_inline = ezini( 'GestioneClassi', 'classi_con_immagine_inline', 'openpa.ini')
     $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiLine', 'openpa.ini')}

<div id="line-{$node.node_id}" class="content-view-line class-folder line-handler {include uri='design:parts/openpa/line_style.tpl'}">
	{if $classi_con_immagine_inline|contains($node.class_identifier)}
		{if $node.data_map.image.has_content}
			<div class="main-image left">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
		{/if}	
	{/if}
	<div class="blocco-titolo-oggetto">
		<div class="titolo-blocco-titolo">
		    <h3><a href={$node.url_alias|ezurl}>{$node.name|wash()}</a></h3>
            {foreach $node.object.contentobject_attributes as $attribute}
                {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier) )}
                    {if $attribute.has_content}
                        {attribute_view_gui href=nolink attribute=$attribute}
                    {/if}			
                {/if}			
            {/foreach}
		</div>       		
	</div>
        
    {if and( $node.data_map.abstract.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/abstract') )|not() )}
    <div class="attribute-short blocco-contenuto-oggetto">
        {attribute_view_gui attribute=$node.data_map.abstract}
    </div>
    {/if}
</div>
