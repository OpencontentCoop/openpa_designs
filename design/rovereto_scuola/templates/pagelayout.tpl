<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it">
<head>
    {if is_set( $extra_cache_key )|not}
        {def $extra_cache_key = ''}
    {/if}

    {set $extra_cache_key = concat($extra_cache_key, $ui_context)}

    {if openpacontext().is_area_tematica}
        {set $extra_cache_key = concat($extra_cache_key, 'areatematica_', openpacontext().is_area_tematica)}
    {/if}

    {debug-accumulator id=section_identification name=section_identification}

    {if is_home()}
        {set $extra_cache_key = concat($extra_cache_key, 'home')}
    {elseif is_section(  'comune' )}
        {set $extra_cache_key = concat($extra_cache_key, 'comune')}
    {elseif is_section(  'citta' )}
        {set $extra_cache_key = concat($extra_cache_key, 'citta')}
    {/if}

    {def $main_sections = openpaini( 'Sezioni', 'Sezione', array() )}
    {if and(is_set(openpacontext().reverse_path_id_array[0]), openpacontext().reverse_path_id_array[0]|ne($main_sections.comune))}
        {set $extra_cache_key = concat($extra_cache_key, 'hide_path')}
    {/if}

    {/debug-accumulator}


    {set $extra_cache_key = concat($extra_cache_key, $ui_context)}

    {debug-accumulator id=page_head_style name=page_head_style}
    {include uri='design:page_head_style.tpl'}
    {/debug-accumulator}

    {debug-accumulator id=page_head_script name=page_head_script}
    {include uri='design:page_head_script.tpl'}
    {include uri='design:page_head_google_tag_manager.tpl'}
    {/debug-accumulator}

    {include uri='design:page_head_google-site-verification.tpl'}

    {include uri='design:page_head.tpl'}
    {no_index_if_needed()}

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />


</head>
<body class="no-js">
{include uri='design:page_body_google_tag_manager.tpl'}
<script src="{'javascript/cookiechoices.js'|ezdesign(no)}"></script>
<script type="text/javascript">
//<![CDATA[
var CurrentUserIsLoggedIn = {cond(fetch('user','current_user').is_logged_in, 'true', 'false')};
var UiContext = "{$ui_context}";
var UriPrefix = {'/'|ezurl()};
var PathArray = [{if is_set( openpacontext().path_array[0].node_id )}{foreach openpacontext().path_array|reverse as $path}{$path.node_id}{delimiter},{/delimiter}{/foreach}{/if}];
(function(){ldelim}var c = document.body.className;c = c.replace(/no-js/, 'js');document.body.className = c;{rdelim})();
//]]>
document.addEventListener('DOMContentLoaded', function(event) {ldelim}cookieChoices.showCookieConsentBar("I cookie ci aiutano ad erogare servizi di qualità. Utilizzando i nostri servizi, l'utente accetta le nostre modalità d'uso dei cookie.",'OK','Maggiori informazioni','{'openpa/cookie'|ezurl(no,full)}');{rdelim});
</script>

<!--[if lt IE 7]>
<div class="alert alert-info">
<p class="browsehappy">Stai usando un browser <strong>obsoleto</strong>. <a href="http://browsehappy.com/">Aggiornalo</a> e navigherai più felice.</p>
</div>
<![endif]-->

<div id="page"{if is_set($module_result.content_info.persistent_variable.background_style)} {$module_result.content_info.persistent_variable.background_style}{/if}{if is_set($module_result.content_info.persistent_variable.page_css_class)} class="{$module_result.content_info.persistent_variable.page_css_class}"{/if}>

    {debug-accumulator id=page_toolbar name=page_toolbar}
    {include uri='design:page_toolbar.tpl'}
    {/debug-accumulator}

    {if and($ui_context|ne('edit'), $ui_context|ne('browse'))}
    {debug-accumulator id=page_header name=page_header}
    {cache-block expiry=86400 ignore_content_expiry keys=array( $access_type.name, $extra_cache_key )}
        {def $pagedata = openpapagedata()}
    {include uri='design:page_header.tpl'}
    {/cache-block}
    {/debug-accumulator}
    {/if}


    {include uri='design:page_mainarea.tpl'}

    {if and($ui_context|ne('edit'), $ui_context|ne('browse'))}
    {debug-accumulator id=page_footer name=page_footer}
    {cache-block expiry=86400 ignore_content_expiry keys=array( $access_type.name, $extra_cache_key )}
    {include uri='design:page_footer.tpl'}
    {/cache-block}
    {/debug-accumulator}
    {/if}

</div>

{include uri='design:page_hidden_path.tpl'}
{include uri='design:page_footer_script.tpl'}


<!--DEBUG_REPORT-->
</body>
</html>