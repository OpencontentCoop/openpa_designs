{if and( $attribute.content.latitude, $attribute.content.longitude )}
{run-once}
<link rel="stylesheet" href="{'stylesheets/leaflet.0.7.2.css'|ezdesign(no)}" />
<script src="{'javascript/leaflet.0.7.2.js'|ezdesign(no)}"></script>
<script src="{'javascript/Leaflet.MakiMarkers.js'|ezdesign(no)}"></script>
{/run-once}

<div id="map-{$attribute.id}" style="width: 100%; height: 200px;"></div>
<p class="goto">
  <a class="btn btn-xs btn-success pull-right" target="_blank" href="https://www.google.com/maps/dir//'{$attribute.content.latitude},{$attribute.content.longitude}'/@{$attribute.content.latitude},{$attribute.content.longitude},15z?hl=it">Come arrivare <i class="fa fa-external-link"></i></a>
</p>

{literal}
<script type="text/javascript">
  var latlng={/literal}[{$attribute.content.latitude},{$attribute.content.longitude}]{literal};
  var map = new L.Map('map-{/literal}{$attribute.id}{literal}');
  map.scrollWheelZoom.disable();
  var customIcon = L.MakiMarkers.icon({icon: "star", color: "#ff0", size: "l"});
  var postMarker = new L.marker(latlng,{icon:customIcon});
  postMarker.addTo(map);
  map.setView(latlng, 18);
  L.tileLayer('//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);
</script>
{/literal}
{/if}
