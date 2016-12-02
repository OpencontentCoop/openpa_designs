<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
<head>

{def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )
     $is_login_page = cond( and( module_params()['module_name']|eq( 'user' ), module_params()['function_name']|eq( 'login' ) ), true(), false() )
     $cookies = check_and_set_cookies()}


{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}
{cache-block expiry=86400 keys=array( $module_result.uri, $user_hash, $extra_cache_key, $cookies|implode(',') )}
{def $browser          = checkbrowser('checkbrowser')     
     $pagedata         = ezpagedata()
     $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $pagedata.node_id
     $main_style       = get_main_style()}

{include uri='design:page_head_google-site-verification.tpl'}
{include uri='design:page_head.tpl'}

<!-- Site: {ezsys( 'hostname' )} -->
{if ezsys( 'hostname' )|contains( 'opencontent' )}
<META name="robots" content="NOINDEX,NOFOLLOW" />
{/if}

{include uri='design:page_head_style.tpl'}
<link href='http://fonts.googleapis.com/css?family=Merriweather+Sans' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href={"stylesheets/dimmi.css"|ezdesign} />
{include uri='design:page_head_script.tpl'}

</head>
<body class="no-js">
<script type="text/javascript">{literal}
//<![CDATA[
var UiContext = {/literal}"{$ui_context}"{literal};
var UriPrefix = {/literal}{'/'|ezurl()}{literal};
var PathArray = [{/literal}{if is_set( $pagedata.path_array[0].node_id )}{foreach $pagedata.path_array|reverse as $path}{$path.node_id}{delimiter},{/delimiter}{/foreach}{/if}{literal}];

(function(){var c = document.body.className;
c = c.replace(/no-js/, 'js');
document.body.className = c;
})();
//]]>{/literal}
</script>
{/cache-block}

{include uri='design:page_browser_alert.tpl'}

{cache-block expiry=86400 keys=array( $module_result.uri, $user_hash, $extra_cache_key )}
<div id="page" class="nosidemenu noextrainfo {$main_style}">

    {if and( is_set( $pagedata.persistent_variable.extra_template_list ), $pagedata.persistent_variable.extra_template_list|count() )}
        {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
            {include uri=concat('design:extra/', $extra_template)}
        {/foreach}
    {/if}

    <div id="header-position">
    <div id="header" class="float-break width-layout">
      
      
            
      <p class="hide"><a href="#main">{'Skip to main content'|i18n('design/ezflow/pagelayout')}</a></p>
    </div>
    </div>
    
    <div id="page-content-position">
    <div id="page-content" class="width-layout">
      
{/cache-block}


{cache-block expiry=86400 keys=array( $module_result.uri, $user_hash, $extra_cache_key )}    
    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
        {*include uri='design:page_toolbar.tpl'*}
    {/if}

    <div id="columns-position" class="width-layout{if $pagedata.class_identifier|eq('frontpage')} frontpage{/if}">
    <div id="columns" class="float-break">

{/cache-block}

    {include uri='design:page_mainarea.tpl'}

{cache-block expiry=86400 keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

    </div>
    </div>
       
</div>

{include uri='design:page_footer_script.tpl'}
{/cache-block}

{* modal window and AJAX stuff 
<div id="overlay-mask" style="display:none;"></div>
<img src={'loading.gif'|ezimage()} id="ajaxuploader-loader" style="display:none;" alt="{'Loading...'|i18n( 'design/admin/pagelayout' )}" />
*}

<!--DEBUG_REPORT-->
</body>
</html>
