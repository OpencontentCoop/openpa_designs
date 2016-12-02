{*
	TEMPLATE FORM, retecivica
	per risposta a chi compila il form di valutazione delle pagine del sito

*}

{default collection=cond( $collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
                          fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}

{set-block scope=global variable=title}{'Form %formname'|i18n('design/standard/content/form',,hash('%formname',$node.name|wash))}{/set-block}
{set-block scope=global variable=subject}{'Form %formname'|i18n('design/standard/content/form',,hash('%formname',$node.name|wash))}{/set-block}

{if and(is_set($node.object.data_map.email_receiver), $node.object.data_map.email_receiver.has_content)}
	{set-block scope=global variable=email_receiver}{$node.object.data_map.email_receiver.content}{/set-block}
{elseif and(is_set($node.object.data_map.recipient), $node.object.data_map.recipient.has_content)}
	{set-block scope=global variable=email_receiver}{$node.object.data_map.recipient.content}{/set-block}
{elseif and(is_set($node.object.data_map.receiver), $node.object.data_map.receiver.has_content)}
	{set-block scope=global variable=email_receiver}{$node.object.data_map.receiver.content}{/set-block}
{/if}

{if and(is_set($node.object.data_map.email_cc_receivers), $node.object.data_map.email_cc_receivers.has_content)}
	{set-block scope=global variable=email_cc_receivers}{$node.object.data_map.email_cc_receivers.content}{/set-block}
{/if}

{if and(is_set($node.object.data_map.email_bcc_receivers), $node.object.data_map.email_bcc_receivers.has_content)}
	{set-block scope=global variable=email_bcc_receivers}{$node.object.data_map.email_bcc_receivers.content}{/set-block}
{/if}

{'Collected information'|i18n('design/standard/content/form')} dal sito del Comune di Trento

{*Pagina: {$node.name} http://{ezsys('hostname')}/{$node.url_alias}*}

{section loop=$collection.attributes}{if $:item.contentclass_attribute.identifier|eq('email')}{set-block scope=global variable=email_reply_to}{attribute_result_gui view=info attribute=$:item}{/set-block}{set-block scope=global variable=email_sender}{attribute_result_gui view=info attribute=$:item}{/set-block}{/if}

== {$:item.contentclass_attribute_name|wash} ==

{if $:item.contentclass_attribute.identifier|eq('link')}

http://{ezsys('hostname')}/{$:item.data_text|wash}

{else}

{attribute_result_gui view=info attribute=$:item}

{/if}

{/section}


