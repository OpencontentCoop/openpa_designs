{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

<!-- Bootstrap core CSS -->
<link href="{'javascript/vendor/bootstrap/dist/css/bootstrap.css'|ezdesign(no)}" rel="stylesheet">

{if $load_css_file_list}
  {ezcss_load( array( 'debug.css',
                      ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
                      ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ),
                      'webfonts.css','icons.css','main.css', 'fix.css', 'plugins/blueimp/blueimp-gallery.css', 'websitetoolbar.css') )}
{else}
  {ezcss_load( array( 'debug.css',
                      'webfonts.css','icons.css','main.css', 'fix.css', 'plugins/blueimp/blueimp-gallery.css', 'websitetoolbar.css') )}
{/if}


<!-- Other styles -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href="{'javascript/vendor/leaflet/dist/leaflet.css'|ezdesign(no)}" rel="stylesheet" >

