{def $collection = cond( $collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
                          fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}

{set-block scope=global variable=title}{'Form %formname'|i18n( 'design/ocbootstrap/collectedinfo/form', , hash( '%formname', $node.name|wash() ) )}{/set-block}

<div class="attribute-header">
    <h1>{$object.name|wash}</h1>
</div>

<p>{'Grazie per il tuo interessamento.'|i18n( 'design/ocbootstrap/collectedinfo/form' )}</p>

{if $error}

{if $error_existing_data}
<p>{'You have already submitted this form. The data you entered was:'|i18n('design/ocbootstrap/collectedinfo/form')}</p>
{/if}

{/if}

{foreach $collection.attributes as $attribute}

<p><strong>{$attribute.contentclass_attribute_name|wash}:</strong> {attribute_result_gui view=info attribute=$attribute} </p>

{/foreach}

<p/>



{if $collection.data_map.link.has_content}	
  <a href={concat( $collection.data_map.link.content)|ezurl()}>{'Return to site'|i18n('design/ocbootstrap/collectedinfo/form')}</a>
{else}
	<a href={$node.parent.url|ezurl}>{'Return to site'|i18n('design/ocbootstrap/collectedinfo/form')}</a>
{/if}