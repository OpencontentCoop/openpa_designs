{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

<style>{literal}
    @font-face {
        font-family: "Open Sans";
        font-style: normal;
        font-weight: 400;
        src: local("Open Sans"), local("OpenSans"), url("://fonts.gstatic.com/s/opensans/v13/cJZKeOuBrn4kERxqtaUH3ZBw1xU1rKptJj_0jans920.woff2") format("woff2");
    }
    @font-face {
        font-family: "Open Sans";
        font-style: normal;
        font-weight: 600;
        src: local("Open Sans Semibold"), local("OpenSans-Semibold"), url("://fonts.gstatic.com/s/opensans/v13/MTP_ySUJH_bn48VBG8sNShampu5_7CjHW5spxoeN3Vs.woff2") format("woff2");
    }
    @font-face {
        font-family: "Open Sans";
        font-style: normal;
        font-weight: 700;
        src: local("Open Sans Bold"), local("OpenSans-Bold"), url("://fonts.gstatic.com/s/opensans/v13/k3k702ZOKiLJc3WVjuplzBampu5_7CjHW5spxoeN3Vs.woff2") format("woff2");
    }
    {/literal}</style>

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
