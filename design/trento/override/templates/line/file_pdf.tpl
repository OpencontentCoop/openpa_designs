{* File pdf - Line view *}
{def $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiLine', 'openpa.ini')}


<div id="line-{$node.node_id}" class="content-view-line">
    <div class="class-file_pdf line-handler {include uri='design:parts/openpa/line_style.tpl'}">
    
    <div class="blocco-titolo-oggetto">
        {include name=edit node=$node uri='design:parts/openpa/edit_buttons.tpl'} 
        {if $node.data_map.file.content.original_filename|ne( concat($node.name, '.', $node.data_map.file.content.mime_type_part) )}
            <h2>{$node.name|wash()}</h2>
        {/if}
        {foreach $node.object.contentobject_attributes as $attribute}
            {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier) )}
                {if $attribute.has_content}
                    {attribute_view_gui href=nolink attribute=$attribute}
                {/if}			
            {/if}			
        {/foreach}
    </div>
    
	{if and( $node.data_map.file.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/file') )|not() )}
		<div class="attribute-file blocco-contenuto-oggetto">
		{attribute_view_gui attribute=$node.data_map.file}
		</div>
	{/if}
    

    </div>
</div>
