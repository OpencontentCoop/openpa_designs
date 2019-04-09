{* Load JavaScript dependencys + JavaScriptList *}
{ezscript_load( array(
    'ezjsc::jquery',
    'ezjsc::jqueryio',
    'leaflet/leaflet.0.7.2.js',
    'leaflet/leaflet.markercluster.js',
    'leaflet/Leaflet.MakiMarkers.js',
    'leaflet/Control.Geocoder.js',
    ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' )
))}
<!--[if lt IE 9]>
<script src={'javascript/html5shiv.js'|ezdesign()}></script>
<script src={'javascript/respond.min.js'|ezdesign()}></script>
<![endif]-->