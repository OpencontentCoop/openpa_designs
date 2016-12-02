{ezpagedata_set( 'left_menu', false() )}
{ezpagedata_set( 'extra_menu', false() )}

{set-block scope=global variable=title}{'Poll %pollname'|i18n('design/standard/content/poll',,hash('%pollname',$node.name|wash))}{/set-block}

<div class="row class-{$node.object.class_identifier}">
    <div class="col-md-12">  
        <h1>{'Poll results'|i18n( 'design/standard/content/poll' )}</h1>

        {if $error}
        
        {if $error_anonymous_user}
        <div class="alert alert-danger">
            <p>{'Anonymous users are not allowed to vote in this poll. Please log in.'|i18n('design/standard/content/poll')}</p>
        </div>
        {/if}
        
        {if $error_existing_data}
        <div class="alert alert-danger">
            <p>{'You have already voted in this poll.'|i18n('design/standard/content/poll')}</p>
        </div>
        {/if}
        
        {/if}

        <h2>{$node.name|wash}</h2>
        
        {section loop=$object.contentobject_attributes}
            {if $:item.contentclass_attribute.is_information_collector}
                <div class="row list">
                    <div class="col-md-3">
                        <strong>{$:item.contentclass_attribute_name|wash}</strong>
                    </div>
                    <div class="col-md-8">
                        {attribute_result_gui view=info attribute=$:item}
                    </div>
                </div>            
            {else}
                <div class="row list">
                    <div class="col-md-3">
                        <strong>{$:item.contentclass_attribute.name}</strong>
                    </div>
                    <div class="col-md-8">
                        {attribute_view_gui attribute=$:item}
                    </div>
                </div> 
            {/if}

        {/section}

        <strong>
        {"%count total votes"|i18n( 'design/standard/content/poll' ,,
                                     hash( '%count', fetch( content, collected_info_count, hash( object_id, $object.id ) ) ) )}
        </strong>
    </div>
</div>    