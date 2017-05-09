<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it">
<head>
{set $current_user = fetch( 'user', 'current_user' )}
{def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )
     $is_login_page = cond( and( module_params()['module_name']|eq( 'user' ), module_params()['function_name']|eq( 'login' ) ), true(), false() )}


{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}

{cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

{def $pagedata         = ezpagedata()
     $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $pagedata.node_id
     $main_style       = get_main_style()
     $extra_menu       = calculate_extra_menu( 'design:page_extramenu.tpl' )
     $left_menu        = calculate_left_menu( 'design:menu/left.tpl' )
     $background       = section_image()
     $background_ignore_home  = section_image( true() )
     $home = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )
}



{include uri='design:page_head.tpl'}

{if ezini( 'SiteSettings', 'SiteURL' )|contains( 'opencontent' )}
{* creato un codice di verifica da Luca il 27/5/13 per rimuovere i contentuti di rovereto.opencontent.it da google *}
<meta name="google-site-verification" content="vJmrgUY7jhJ0I7cSS3gTj2LI-DWXCyZMefGXmcwhhYU" />
<META name="robots" content="NOINDEX,NOFOLLOW" />
{/if}
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

<!--[if lt IE 9]>
<script src={'javascript/html5shiv.js'|ezdesign()}></script>
<script src={'javascript/respond.min.js'|ezdesign()}></script>
<![endif]-->

</head>
<body>
  
<script src="{'javascript/cookiechoices.js'|ezdesign(no)}"></script>
{literal}
<script>
document.addEventListener('DOMContentLoaded', function(event) {cookieChoices.showCookieConsentBar("I cookie ci aiutano ad erogare servizi di qualità. Utilizzando i nostri servizi, l'utente accetta le nostre modalità d'uso dei cookie.",'OK','Maggiori informazioni','{/literal}{'openpa/cookie'|ezurl(no,full)}{literal}');});
</script>
{/literal}

<!--[if lt IE 7]>
<div class="alert alert-info">
<p class="browsehappy">Stai usando un browser <strong>obsoleto</strong>. <a href="http://browsehappy.com/">Aggiornalo</a> e navigherai più felice.</p>
</div>
<![endif]-->

{if is_home()}
    {include uri='design:home_gallery.tpl'}
{/if}

<div id="page"
{*if $ui_context|eq( 'browse' )}
{elseif $ui_context|eq( 'edit' )*}

{if $background_ignore_home|ne(false())  } style="background: url({$background_ignore_home.background.url|ezroot(no)}) no-repeat top center;"
{elseif $home.data_map.cover.has_content} style="background: url({$home.data_map.cover.content.background.url|ezroot(no)}) no-repeat top center;"
{elseif is_home()} class="home"
{/if}>

    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not, is_set( $view_parameters.view )|not)}
        {include uri='design:page_toolbar.tpl'}
    {/if}

    {include uri='design:page_header.tpl'}


{* Il div.container è aperto all'interno dei page_header*.tpl *}    

    <div class="row">
    
    {def $has_leftmenu = false()}
    {if and( $pagedata.left_menu, or( is_home()|not, is_section( 'comune' ), is_section( 'citta' ), is_area_tematica() ) )}
        {set $has_leftmenu = true()}
    {/if}
    
    {if and( $has_leftmenu, $left_menu )}
    <div class="col-md-2 leftmenu">
        {$left_menu}
    </div>
    {/if}
       
    <div class="body col-md-{if and( $has_leftmenu, $pagedata.extra_menu )}6{elseif $has_leftmenu}10{elseif $pagedata.extra_menu}8{else}12{/if}">        
{/cache-block} 
        {$module_result.content}
{cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}    
    </div>
    
    {if is_unset($pagedata)}
        {def $pagedata = ezpagedata()}
    {/if}

    {if and( $pagedata.extra_menu, $module_result.content_info )}
        <div class="col-md-4 extramenu">
            {$extra_menu}
        </div>
    {/if}    	
    
    </div>
    
    {include name=footer_menu node_id=$current_node_id uri='design:page_footermenu.tpl'}
{/cache-block}

{cache-block keys=array( $module_result.uri, $current_user.contentobject_id, $extra_cache_key )}    
    
    {* Il div.container è chiuso all'interno dei page_footer.tpl *}    
    {include uri='design:page_footer.tpl'}


</div>

{include uri='design:page_footer_script.tpl'}

{/cache-block}

<!--DEBUG_REPORT-->
</body>
</html>