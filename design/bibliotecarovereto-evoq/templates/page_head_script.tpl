{* Load JavaScript dependencys + JavaScriptList *}
{ezscript_load( array(
    'ezjsc::jquery',
    'ezjsc::jqueryio',
    'chosen.jquery.js',
    ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ),
    ezini( 'JavaScriptSettings', 'FrontendJavaScriptList', 'design.ini' )
))}

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
