{ezscript_require( array( 'http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js' ) )}
{ezcss_require( array( 'http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css' ) )}

{if $attribute.has_content}
<script type="text/javascript">
<!--
if ( window.addEventListener )
    window.addEventListener('load', function(){ldelim} doMap( {$attribute.id}, "{$attribute.object.name|wash(javascript)}", {first_set( $attribute.content.latitude, '0.0')}, {first_set( $attribute.content.longitude, '0.0')} ) {rdelim}, false);
else if ( window.attachEvent )
    window.attachEvent('onload', function(){ldelim} doMap( {$attribute.id}, "{$attribute.object.name|wash(javascript)}", {first_set( $attribute.content.latitude, '0.0')}, {first_set( $attribute.content.longitude, '0.0')} ) {rdelim} );
-->
</script>

<div id="leaflet-map-{$attribute.id}" style="width: 100%; height: 280px;"></div>
{/if}

{run-once}
<script type="text/javascript">
/* <![CDATA[ */
{literal}
OSM_URL = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
OSM_ATTRIB = '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a>'; 
function doMap( attributeId, text, latitude, longitude )
{
    var map = L.map('leaflet-map-'+attributeId).setView([latitude, longitude], 13);
    L.tileLayer(OSM_URL, {attribution: OSM_ATTRIB}).addTo(map);
    var marker = L.marker([latitude, longitude]).bindPopup(text).addTo(map).openPopup();    
}
/* ]]> */
{/literal}

</script>
{/run-once}
