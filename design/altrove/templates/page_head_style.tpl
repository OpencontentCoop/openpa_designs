{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

<style>{literal}
    @font-face {
        font-family: "Open Sans";
        font-style: normal;
        font-weight: 400;
        src: local("Open Sans"), local("OpenSans"), url("http://fonts.gstatic.com/s/opensans/v13/cJZKeOuBrn4kERxqtaUH3ZBw1xU1rKptJj_0jans920.woff2") format("woff2");
    }
    @font-face {
        font-family: "Open Sans";
        font-style: normal;
        font-weight: 600;
        src: local("Open Sans Semibold"), local("OpenSans-Semibold"), url("http://fonts.gstatic.com/s/opensans/v13/MTP_ySUJH_bn48VBG8sNShampu5_7CjHW5spxoeN3Vs.woff2") format("woff2");
    }
    @font-face {
        font-family: "Open Sans";
        font-style: normal;
        font-weight: 700;
        src: local("Open Sans Bold"), local("OpenSans-Bold"), url("http://fonts.gstatic.com/s/opensans/v13/k3k702ZOKiLJc3WVjuplzBampu5_7CjHW5spxoeN3Vs.woff2") format("woff2");
    }
{/literal}</style>

{if $load_css_file_list}
{ezcss_load( array(
    'app.css', 'app_2.css', 'app_3.css', 'custom.css',
    'leaflet/leaflet.0.7.2.css',
    'debug.css',
    'websitetoolbar.css',
    ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
    ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' )
),
'all', 'text/css', 'stylesheet' )}
{else}
{ezcss_load( array(
    'app.css', 'app_2.css', 'app_3.css', 'custom.css',
    'leaflet/leaflet.0.7.2.css',
    'debug.css',
    'websitetoolbar.css'
),
'all', 'text/css', 'stylesheet' )}
{/if}
