<!DOCTYPE html>
<!--[if lt IE 9 ]><html class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>

{def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{cache-block keys=array( $module_result.uri, $current_user.contentobject_id )}

{def $pagedata = ezpagedata()
     $pagestyle = $pagedata.css_classes
     $locales = fetch( 'content', 'translation_list' )
     $current_node_id = $pagedata.node_id}

<meta name="viewport" content="width=device-width, initial-scale=1.0">
{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>

<div id="page" class="container">

    <div class="row">  
      
        <div class="col-md-12">            
        {/cache-block}                
        {$module_result.content}
        {cache-block keys=array( $module_result.uri, $current_user.contentobject_id )}
        </div>
    
    </div>

</div>    
{include uri='design:page_footer_script.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
