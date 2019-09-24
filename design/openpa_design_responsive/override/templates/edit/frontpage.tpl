{def $_redirect = false()}
{if ezhttp_hasvariable( 'LastAccessesURI', 'session' )}
    {set $_redirect = ezhttp( 'LastAccessesURI', 'session' )}
{elseif $object.main_node_id}
    {set $_redirect = concat( 'content/view/full/', $object.main_node_id )}
{elseif ezhttp( 'url', 'get', true() )}
    {set $_redirect = ezhttp( 'url', 'get' )}
{/if}  
<form class="edit" enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>
    {include uri='design:parts/website_toolbar_edit.tpl'}
    
    
    {include uri="design:content/edit_validation.tpl"}
    
    <div class="pull-right">
        {def $language_index = 0
             $from_language_index = 0
             $translation_list = $content_version.translation_list}
    
        {foreach $translation_list as $index => $translation}
           {if eq( $edit_language, $translation.language_code )}
              {set $language_index = $index}
           {/if}
        {/foreach}
    
        {if $is_translating_content}
    
            {def $from_language_object = $object.languages[$from_language]}
    
            {'Translating content from %from_lang to %to_lang'|i18n( 'design/ezwebin/content/edit',, hash(
                '%from_lang', concat( $from_language_object.name, '&nbsp;<img src="', $from_language_object.locale|flag_icon, '" style="vertical-align: middle;" alt="', $from_language_object.locale, '" />' ),
                '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" style="vertical-align: middle;" alt="', $translation_list[$language_index].language_code, '" />' ) ) )}
    
        {else}
    
            {'Content in %language'|i18n( 'design/ezwebin/content/edit',, hash( '%language', $translation_list[$language_index].locale.intl_language_name ))}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" style="vertical-align: middle;" alt="{$translation_list[$language_index].language_code}" />
    
        {/if}
    </div>

    <h2>{"Edit %1 - %2"|i18n("design/standard/content/edit",,array($class.name|wash,$object.name|wash))}</h2>
    
    
    <div class="row">

        <div class="col-md-12">
                
            {include uri="design:content/edit_attribute.tpl"}
        
            <div class="buttonblock">
                <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/standard/content/edit')|wash()}" />
                <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n('design/standard/content/edit')|wash()}" />
                <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/standard/content/edit')|wash()}" />
                <input type="hidden" name="RedirectIfDiscarded" value="{$_redirect|wash()}" />
                <input type="hidden" name="RedirectURIAfterPublish" value="{$_redirect|wash()}" />
            </div>
        </div>
{*
        <div class="col-md-3">

            <div class="panel panel-info">
                <div class="panel-heading">Carica nei blocchi</div>
                <div id="ajaxsearchbox" class="panel-body">
                    
                    <div class="input-group">
                        <input placeholder="{'Search phrase'|i18n( 'design/ezflow/edit/frontpage' )}" id="search-string-{$object.id}" name="SearchStr"  type="text" size="20" class="form-control ezobject-relation-search-text">
                        <input name="SearchOffset" type="hidden" value="0"  />
                        <input name="SearchLimit" type="hidden" value="10"  />
                        <span class="input-group-btn">
                            <button id="search-button-{$object.id}" title="{'Search'|i18n( 'design/ezflow/edit/frontpage' )}"  name="CustomActionButton[22825_browse_objects]" class="button ezobject-relation-search-btn btn btn-sm btn-info btn-sm" type="submit"><span class="glyphicon glyphicon-search"></span></button>
                        </span>
                    </div>
                  
                    <div class="form-group">
                        <label style="display: block">From:</label>
                            <select class="form-control" style="width: 30%; display: inline">
                                <option>September</option>
                            </select>
                            <select class="form-control" style="width: 30%; display: inline">
                                <option>23</option>
                            </select>
                            <select class="form-control" style="width: 30%; display: inline">
                                <option>2007</option>
                            </select>
                        <label style="display: block">To:</label>
                            <select class="form-control" style="width: 30%; display: inline">
                                <option>October</option>
                            </select>
                            <select class="form-control" style="width: 30%; display: inline">
                                <option>12</option>
                            </select>
                            <select class="form-control" style="width: 30%; display: inline">
                                <option>2007</option>
                            </select>
                    </div>                    
                    
                    <div class="block search-results">
                        <span class="header">{'Results'|i18n( 'design/ezflow/edit/frontpage' )}</span>
                        <div id="search-results-{$object.id}" style="overflow: hidden"></div>
                    </div>
                
                    {foreach $content_attributes as $content_attribute}
                    {if eq( $content_attribute.data_type_string, 'ezpage' )}
                    <script type="text/javascript">
                    {literal}
                    function addBlock( object, id )
                    {
                        var $select = object;
                        var $id = id;
                        var addToBlock = document.getElementById( 'addtoblock' );
                        addToBlock.name = 'CustomActionButton[' + $id  +'_new_item' + '-' + $select.value + ']';
                    }
                    {/literal}
                    </script>
                    <div class="form-group">
                    <select name="zonelist" class="form-control" onchange="addBlock( this, {$content_attribute.id} );">
                    <option>{'Select:'|i18n( 'design/ezflow/edit/frontpage' )}</option>
                    {def $zone_id = ''
                         $zone_name = ezini( $content_attribute.content.zone_layout, 'ZoneName', 'zone.ini' )}
                        {foreach $content_attribute.content.zones as $index => $zone}
                        {if and( is_set( $zone.action ), eq( $zone.action, 'remove' ) )}
                            {skip}
                        {/if}
                        {set $zone_id = $index}
                        <optgroup label="{$zone_name[$zone.zone_identifier]}">
                            {if and( is_set( $zone.blocks ), $zone.blocks|count() )}
                            {foreach $zone.blocks as $index => $block}
                            <option value="{$zone_id}-{$index}">{$index|inc}: {ezini( $block.type, 'Name', 'block.ini' )}</option>
                            {/foreach}
                            {/if}
                        </optgroup>
                        {/foreach}
                    </select>
                    </div>
                    <input id="addtoblock" class="button" type="submit" name="CustomActionButton[{$content_attribute.id}_new_item]" value="{'Add to block'|i18n( 'design/ezflow/edit/frontpage' )}" />
                    {/if}
                    {/foreach}
                
                </div>
                
                {ezscript_require( array( 'ezjsc::yui3', 'ezjsc::yui3io', 'ezajaxsearch.js' ) )}
                
                <script type="text/javascript">
                eZAJAXSearch.cfg = {ldelim}
                                        searchstring: '#search-string-{$object.id}',
                                        searchbutton: '#search-button-{$object.id}',
                                        searchresults: '#search-results-{$object.id}',
                                        resulttemplate: '<div class="result-item float-break"><span class="item-selector"><input type="checkbox" value="{ldelim}object_id{rdelim}" name="SelectedObjectIDArray[]" /></span> <span class="item-title">{ldelim}title{rdelim}</span> <span class="item-published-date">[{ldelim}class_name{rdelim}] {ldelim}date{rdelim}</span></div>'
                                   {rdelim};
                eZAJAXSearch.init();
                </script>
                
                <!-- SEARCH BOX: END -->
                
            </div>
            
            {include uri="design:content/edit_right_menu.tpl"}    
            
        </div>
*}        
    </div>   
</form>

{undef $_redirect}