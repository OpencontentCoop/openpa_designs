{def $AttributiNonEditabili = ezini( 'GestioneAttributi', 'AttributiNonEditabili', 'openpa.ini')}
    {default $view_parameters=array()}
    {section name=ContentObjectAttribute loop=$content_attributes}
	  {def $contentclass_attribute = $ContentObjectAttribute:item.contentclass_attribute}
	  
<div class="block ezcca-edit-datatype-{$ContentObjectAttribute:item.data_type_string} ezcca-edit-{$ContentObjectAttribute:item.contentclass_attribute_identifier}{if $AttributiNonEditabili|contains(concat($class.identifier,'/',$ContentObjectAttribute:item.contentclass_attribute_identifier))} hidden{/if}">   
    <label {if $ContentObjectAttribute:item.has_validation_error} class="validation-error"{/if}>
		{$ContentObjectAttribute:item.contentclass_attribute.name|wash}
	</label>
	<div class="labelbreak"></div>
    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$ContentObjectAttribute:item.id}" />
	{if $contentclass_attribute.description} <em class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</em>{/if}
    {attribute_edit_gui attribute_base=$attribute_base attribute=$ContentObjectAttribute:item view_parameters=$view_parameters}
</div>


{/section}
{/default}
