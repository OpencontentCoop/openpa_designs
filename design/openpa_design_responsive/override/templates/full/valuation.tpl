{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}


<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

        <h1>{$node.name|wash()}</h1>
        
        {* DATA e ULTIMAMODIFICA *}
        {include name = last_modified
                 node = $node             
                 uri = 'design:parts/openpa/last_modified.tpl'}
        
        {* EDITOR TOOLS *}
        {include name = editor_tools
                 node = $node             
                 uri = 'design:parts/openpa/editor_tools.tpl'}
    
        {include name=Validation uri='design:content/collectedinfo_validation.tpl'
                 class='message-warning'
                 validation=$validation
                 collection_attributes=$collection_attributes}
                         
        <form method="post" action={"content/action"|ezurl}>
            <div class="attributi-base">
                
                {foreach $node.object.contentobject_attributes as $attribute}
                    {if $attribute.is_information_collector}
                    <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
						<div class="col-md-3 attribute-label">{$attribute.contentclass_attribute_name}</div>
                        <div class="col-md-9">
                            {attribute_view_gui attribute=$attribute}
                        </div>
                    </div>
                    
                    {/if}
                {/foreach}
                <div class="content-action">
                    <input type="submit" class="defaultbutton" name="ActionCollectInformation" value="{"Send form"|i18n("design/ezwebin/full/feedback_form")}" />
                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="ViewMode" value="full" />
                </div>
            </div>
                
        </form>
        
    </div>
</div>
