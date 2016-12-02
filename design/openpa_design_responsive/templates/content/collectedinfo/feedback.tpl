{ezpagedata_set( 'left_menu', false() )}
{ezpagedata_set( 'extra_menu', false() )}
{default collection=cond( $collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
                          fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}

{set-block scope=global variable=title}{'Feedback for %feedbackname'|i18n('design/standard/content/feedback',,hash('%feedbackname',$node.name|wash))}{/set-block}

<div class="row">
    <div class="col-md-12">
    
        <h1>{$object.name|wash}</h1>
        
        {if $error}
        
        {if $error_existing_data}
        <div class="alert alert-danger">
        <p>{'You have already submitted feedback. The previously submitted data was:'|i18n('design/standard/content/feedback')}</p>
        </div>
        {/if}
        
        {else}
        <div class="alert alert-success">
        <p>{'Thanks for your feedback. The following information was collected.'|i18n('design/standard/content/feedback')}</p>
        </div>
        {/if}


        {section loop=$collection.attributes}
        <div class="row list">
        
            <div class="col-md-3">
                <strong>{$:item.contentclass_attribute_name|wash}</strong>
            </div>
            <div class="col-md-8">
                {attribute_result_gui view=info attribute=$:item}
            </div>
        </div>            
        {/section}


        <a class="btn btn-primary btn-lg" href={$node.parent.url|ezurl}>{'Return to site'|i18n('design/standard/content/feedback')}</a>

    </div>
</div>
{/default}
