{*
	TEMPLATE  per la valutazione delle pagine da parte degli utenti
	node_id	nodo di riferimento
*}

{def $valuations=fetch( 'content', 'class', hash( 'class_id', 'valuation' ) )}

{if and( $valuations|count(), $valuations.object_list|count() )}
<div class="row well valuation">
    <div class="col-md-12">

{def $valutazione=$valuations.object_list[0]
	 $node = fetch(content,node,hash(node_id,$node_id))
	 $data_map=$valutazione.data_map}
    <h4>{$valutazione.name|wash()}</h4>
    <form action={"/content/action"|ezurl()} method="post" {*role="form"*}>
        
        <div class="row"> 
            <div class="col-lg-6">
                {if is_set( $data_map.useful )}            
                    <input type="hidden" value="" name="ContentObjectAttribute_ezselect_selected_array_{$data_map.useful.id}" />                
                    <label class="control-label">{$data_map.useful.contentclass_attribute_name|wash()}</label>
                    <div class="utilita-container">
                        <div class="utilita">
                            <label for="utilita1"><input id="utilita1" type="radio" value="0" name="ContentObjectAttribute_ezselect_selected_array_{$data_map.useful.id}[]" /> per nulla</label>
                        </div>
                        <div class="utilita">
                            <label for="utilita2"><input id="utilita2" type="radio" value="1" name="ContentObjectAttribute_ezselect_selected_array_{$data_map.useful.id}[]" /> poco</label>
                        </div>
                        <div class="utilita">
                            <label for="utilita3"><input id="utilita3" type="radio" value="2" name="ContentObjectAttribute_ezselect_selected_array_{$data_map.useful.id}[]" /> abbastanza</label>
                        </div>
                        <div class="utilita">
                            <label for="utilita4"><input id="utilita4" type="radio" value="3" name="ContentObjectAttribute_ezselect_selected_array_{$data_map.useful.id}[]" /> molto</label>
                        </div>
                    </div>            
                {/if}
                
                {if is_set( $data_map.email_aiutaci )}
                <div class="form-group">
                    <label for="helpemail_aiutaci" class="control-label">{$data_map.email_aiutaci.contentclass_attribute_name|wash()}</label>                
                    <input id="helpemail_aiutaci" class="form-control" type="text" value="" name="ContentObjectAttribute_ezstring_data_text_{$data_map.email_aiutaci.id}"  />                
                </div>
                {/if}

                {if is_set($data_map.antispam)}
                    {if $data_map.antispam.data_type_string|eq('ocrecaptcha')}
                        <div class="form-group">
                            <label for="helpcomment" class="control-label">{$data_map.antispam.contentclass_attribute_name|wash()}</label>
                            {attribute_view_gui attribute=$data_map.antispam}
                        </div>
                    {else}
                        {ezcss_require( array( 'nxc.captcha.css' ) )}
                        {ezscript_require( array( 'nxc.captcha.js' ) )}

                        {def $attribute = $data_map.antispam
                             $class_content = $attribute.contentclass_attribute.content
                             $collection_attribute = $collection_attributes[$attribute.id]
                             $regenerate = 1}
                        {if ezhttp( 'ActionCollectInformation', 'post', true() )}
                            {set $regenerate = 0}
                        {/if}

                        {if eq( $collection_attribute.data_int, 0 )}
                            <label for="nxc-captcha-collection-input-{$attribute.id}" class="control-label">Antispam</label>
                            <p>
                                <img id="nxc-captcha-{$attribute.id}" alt="{'Secure code'|i18n( 'extension/nxc_captcha' )}" title="{'Secure code'|i18n( 'extension/nxc_captcha' )}" src="{concat( 'nxc_captcha/get/', $attribute.contentclass_attribute.id, '/nxc_captcha_collection_attribute_', $attribute.id, '/', $regenerate )|ezurl( 'no' )}" />
                                <a href="{concat( 'nxc_captcha/get/', $attribute.contentclass_attribute.id, '/nxc_captcha_collection_attribute_', $attribute.id, '/1' )|ezurl( 'no' )}" class="nxc-captcha-regenerate" id="nxc-captcha-regenerate-{$attribute.id}">Ricarica</a>
                            </p>
                            <p>
                                <input class="captcha-input form-control" id="nxc-captcha-collection-input-{$attribute.id}" type="text" name="nxc_captcha_{$attribute.id}" value="{$collection_attribute.data_text}" size="{$class_content.length.value}" maxlength="{$class_content.length.value}" />
                            </p>
                        {else}
                            {*<p>{'Secure code is allready entered'|i18n( 'extension/nxc_captcha' )}</p>*}
                            <input type="hidden" name="nxc_captcha_{$attribute.id}" value="{$collection_attribute.data_text}" />
                        {/if}
                        {undef $attribute $class_content $collection_attribute $regenerate}
                    {/if}
                {/if}
                
            </div>
            
            <div class="col-lg-6">           
                {if is_set( $data_map.comment )}
                <div class="form-group">
                    <label for="helpcomment" class="control-label">{$data_map.comment.contentclass_attribute_name|wash()}</label>
                    <textarea style="height: 240px" id="helpcomment" class="form-control" name="ContentObjectAttribute_ezstring_data_text_{$data_map.comment.id}" cols="20" rows="4"></textarea>                
                </div>
                {/if}
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <input class="box" type="hidden" value="Nodo: {$node.node_id}; Oggetto:{$node.contentobject_id}; Versione: {$node.contentobject_version}; Titolo: {$node.name|wash()}" name="ContentObjectAttribute_ezstring_data_text_{$data_map.nodo.id}" />	
                <input class="box" type="hidden" value="{$node.url_alias|ezurl(no,full)}" name="ContentObjectAttribute_ezstring_data_text_{$data_map.link.id}" />
                <input type="hidden" value="{$valutazione.main_node.node_id}" name="TopLevelNode"/>
                <input type="hidden" value="{$valutazione.main_node.node_id}" name="ContentNodeID"/>
                <input type="hidden" value="{$valutazione.id}" name="ContentObjectID"/>
                <input type="hidden" name="ViewMode" value="full" />            
                <input class="defaultbutton pull-right" type="submit" value="Invia la valutazione" name="ActionCollectInformation"/>
            </div>
        </div>
    </form>

    </div>
</div>
{/if}