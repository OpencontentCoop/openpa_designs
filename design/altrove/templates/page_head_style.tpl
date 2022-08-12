{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

<link type="text/css" rel="stylesheet" media="all" href="{'stylesheets/opensans.css'|ezdesign(no)}" />
<link type="text/css" rel="stylesheet" media="all" href="{'stylesheets/app.css'|ezdesign(no)}" />
<!--[if lte IE 9]>
<link type="text/css" rel="stylesheet" media="all" href="{'stylesheets/app_1.css'|ezdesign(no)}" />
<link type="text/css" rel="stylesheet" media="all" href="{'stylesheets/app_2.css'|ezdesign(no)}" />
<link type="text/css" rel="stylesheet" media="all" href="{'stylesheets/app_3.css'|ezdesign(no)}" />
<![endif]-->

{if $load_css_file_list}
    {ezcss_load( array(
    'custom.css',
    'leaflet/leaflet.0.7.2.css',
    'debug.css',
    'websitetoolbar.css',
    'plugins/owl-carousel/owl.carousel.css',
    'plugins/owl-carousel/owl.theme.css',
    "plugins/blueimp/blueimp-gallery.css",
    'plugins/table-calendar.css',
    'leaflet/leaflet.css',
    'leaflet/map.css',
    'leaflet/MarkerCluster.css',
    'leaflet/MarkerCluster.Default.css',
    'controls-audio.css',
    'dataTables.bootstrap.css',
    'fuelux.css',
    ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
    ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' )
    ),
    'all', 'text/css', 'stylesheet' )}
{else}
    {ezcss_load( array(
    'custom.css',
    'leaflet/leaflet.0.7.2.css',
    'debug.css',
    'websitetoolbar.css',
    'plugins/owl-carousel/owl.carousel.css',
    'plugins/owl-carousel/owl.theme.css',
    "plugins/blueimp/blueimp-gallery.css",
    'plugins/table-calendar.css',
    'leaflet/leaflet.css',
    'leaflet/map.css',
    'leaflet/MarkerCluster.css',
    'leaflet/MarkerCluster.Default.css',
    'controls-audio.css',
    'dataTables.bootstrap.css',
    'fuelux.css'
    ),
    'all', 'text/css', 'stylesheet' )}
{/if}

<link rel="stylesheet" type="text/css" href={"stylesheets/print.css"|ezdesign} media="print" />
