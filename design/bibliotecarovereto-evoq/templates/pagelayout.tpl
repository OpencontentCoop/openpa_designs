<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!--[if lt IE 9 ]>
<html class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]>
<html class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>
    {def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

    {def $pagedata = ezpagedata()}
    {def $current_node_id  = $pagedata.node_id}

    {if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
    {/if}

    {debug-accumulator id=page_head name=page_head}
    {include uri='design:page_head.tpl'}
    {/debug-accumulator}

    {debug-accumulator id=page_head_style name=page_head_style}
    {include uri='design:page_head_style.tpl'}
    {/debug-accumulator}

    {debug-accumulator id=page_head_script name=page_head_script}
    {include uri='design:page_head_script.tpl'}
    {include uri='design:page_head_google_tag_manager.tpl'}
    {include uri='design:page_head_google-site-verification.tpl'}
    {/debug-accumulator}

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    {no_index_if_needed()}


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

    {debug-accumulator id=page_toolbar name=page_toolbar}
    {include uri='design:page_toolbar.tpl'}
    {/debug-accumulator}

    {def $section = 'default'}
    {if $pagedata.path_id_array|contains(ezini( 'NodeSettings', 'PatrimonioNode', 'content.ini' ))}
        {set $section = 'section-patrimonio-e-risorse'}
    {elseif $pagedata.path_id_array|contains(ezini( 'NodeSettings', 'CalendarNode', 'content.ini' ))}
        {set $section = 'section-eventi-e-attivita'}
    {/if}

    <header id="main-header" class="{$section}">
        {cache-block expiry=86400 ignore_content_expiry keys=array( $access_type.name, $section, $extra_cache_key )}
        {if is_set($pagedata)|not()}{def $pagedata = ezpagedata()}{/if}
        {include uri='design:page_header.tpl'}
        {/cache-block}

        {if and(ne($pagedata.node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' )), ne($pagedata.node_id, ezini( 'NodeSettings', 'PatrimonioNode', 'content.ini' )), ne($pagedata.class_identifier, 'target'))}
        {include uri='design:parts/path.tpl'}
        {/if}
    </header>

    {if is_set($module_result.content_info.persistent_variable.has_container)|not()}
    <div id="main-container" class="layout-page">
        <section class="main-content">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-12 col-lg-12 column-content">
    {/if}

                        {$module_result.content}

    {if is_set($module_result.content_info.persistent_variable.has_container)|not()}
                        </div>
                    </div>
                </div>
        </section>
    </div>
    {/if}

    {cache-block expiry=86400 ignore_content_expiry keys=array( $access_type.name )}
    {include uri='design:page_footer.tpl'}

    {include uri='design:page_footer_script.tpl'}

    {include uri='design:page_extra.tpl'}
    {/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
