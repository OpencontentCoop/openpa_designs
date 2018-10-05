{def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}
<!DOCTYPE html>
<html lang="it">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!--CSS-->
    <link rel="stylesheet" type="text/css" href={"stylesheets/bootstrap.min.css"|ezdesign()}>
    <link rel="stylesheet" type="text/css" href={"stylesheets/style.css"|ezdesign()}>
    <link rel="stylesheet" type="text/css" href={"stylesheets/custom.css"|ezdesign()}>
    <link rel="stylesheet" type="text/css" href={"stylesheets/royalslider.css"|ezdesign()}>
    <link rel="stylesheet" type="text/css" href={"stylesheets/debug.css"|ezdesign()}>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

{cache-block keys=array( $access_type.name )}
    
    {if is_set($module_result.content_info.persistent_variable.site_title)}
	  {set scope=root site_title=$module_result.content_info.persistent_variable.site_title}
    {elseif and( is_set( $module_result.node_id ), $module_result.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}    
	  {set-block scope=root variable=site_title}
		{foreach $module_result.path|array_reverse as $item}{$item.text|wash}{break}{/foreach}
	  {/set-block}
    {else}
	  {def $site_title = false()}
    {/if}
    <title>{if $site_title}{$site_title} - {/if}Sito ufficiale del Teatro Riccardo Zandonai - Rovereto</title>
  </head>

    {def $pagedata = ezpagedata()}
  
  <body{if $pagedata.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )} class="inner-page"{/if}>
    
    <script src="{'javascript/cookiechoices.js'|ezdesign(no)}"></script>
    {literal}
    <script>
    document.addEventListener('DOMContentLoaded', function(event) {cookieChoices.showCookieConsentBar("I cookie ci aiutano ad erogare servizi di qualità. Utilizzando i nostri servizi, l'utente accetta le nostre modalità d'uso dei cookie.",'OK','Maggiori informazioni','{/literal}{'openpa/cookie'|ezurl(no,full)}{literal}');});
    </script>
    {/literal}
    

    {if or( is_set( $pagedata.persistent_variable.header )|not(), $pagedata.persistent_variable.header|ne( false() ) )}    
    <header class="default-header">
      <div class="container">
        {include uri="design:menu.tpl"}
      </div><!--container-->
    </header>
    <div class="container default-container">
    {/if}
    
{/cache-block}
    
    {$module_result.content}
    
{cache-block keys=array( $access_type.name )}
    
    {if is_set( $pagedata )|not()}
      {def $pagedata = ezpagedata()}
    {/if}
    
    {if or( is_set( $pagedata.persistent_variable.header )|not(), $pagedata.persistent_variable.header|ne( false() ) )}
    </div>
    {/if}

    {include uri="design:footer.tpl"}
    
    {include uri="design:footer_script.tpl"}
    
  </body>
</html>
{/cache-block}