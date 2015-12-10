{*
	TEMPLATE FORM, retecivica
	per risposta a chi compila il form di valutazione delle pagine del sito

*}

{ezpagedata_set( 'left_menu', false() )}
{ezpagedata_set( 'extra_menu', false() )}

{default collection=cond( $collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
                          fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}

{set-block scope=global variable=title}{'Form %formname'|i18n('design/standard/content/form',,hash('%formname',$node.name|wash))}{/set-block}
{set-block scope=root variable=email_receiver}nospam@ez.no{/set-block}
{set-block scope=root variable=email_sender}custom_sender@example.com{/set-block}
{set-block scope=root variable=email_reply_to}custom_reply_to@example.com{/set-block}

<div class="row class-{$node.object.class_identifier}">
    <div class="col-md-12">    
    
        <h1>Informazioni per l'utente</h1>
    
        <h2>Grazie di aver compilato il form di valutazione "{$object.name|wash}"</h2>
    
        {if $error}
        
        {if $error_existing_data}
            <div class="alert alert-danger">
            <p>{'You have already submitted this form. The previously submitted data was:'|i18n('design/standard/content/form')}</p>
            </div>
        {/if}
        
        {/if}
    
    
        <h3>{'Collected information'|i18n('design/standard/content/form')}</h3>
    
        {section loop=$collection.attributes}
        <div class="row list">
        
            <div class="col-md-6">
                <strong>{$:item.contentclass_attribute_name|wash}</strong>
            </div>
            <div class="col-md-6">
                {attribute_result_gui view=info attribute=$:item}
            </div>
        </div>            
        {/section}
        
    
        {if $collection.data_map.link.has_content}
            <a class="btn btn-primary btn-lg" href={concat( $collection.data_map.link.content)|ezurl()}>{'Return to site'|i18n('design/standard/content/form')}</a>
        {else}
            <a class="btn btn-primary btn-lg" href={$node.parent.url|ezurl}>{'Return to site'|i18n('design/standard/content/form')}</a>
        {/if}
        
        {/default}
    
    </div>
</div>


