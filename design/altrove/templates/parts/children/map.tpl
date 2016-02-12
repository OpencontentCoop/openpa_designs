{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

{set_defaults(hash(
  'height', 600,
  'map_type', 'osm',
  'class_identifiers', array()
))}

{set $height = $height|fix_dimension()}
{*def $markers = fetch( 'ocbtools', 'map_markers', hash( 'parent_node_id', $node.node_id, class_identifiers, $class_identifiers ) )}
{if $markers|count()*}

<div class="row">
  <div class="col-md-12">
	<div id="map-{$node.node_id}" style="height: {$height}px; width: 100%"></div>

	<script>

{*        console.log("PIER: " + {$class_identifiers});*}
	{literal}
	  //var tiles = L.tileLayer('//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
	  var tiles = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
	  var map = L.map('{/literal}map-{$node.node_id}{literal}').addLayer(tiles);
	  map.scrollWheelZoom.disable();
	  var markers = L.markerClusterGroup();


	  var markerMap = {};
	  $.getJSON("{/literal}{concat('/openpa/data/map_markers'|ezurl(no), '?parentNode=',$node.node_id, '&classIdentifiers=', $class_identifiers|implode(',') )}{literal}&contentType=geojson", function(data) {

	  console.log("PIER 1: " + JSON.stringify(data));

		$.each(data.features, function(i,v){
		  //var markerListItem = $("<li data-id='"+v.id+"'><a href='"+v.properties.url+"'><small>"+v.properties.type+"</small> "+v.properties.name+"</a></li>");
		  var markerListItem = $("<li data-id='"+v.id+"'><a href='"+v.properties.url+"'>"+v.properties.name+"</a></li>");

		  console.log("PIER: " + JSON.stringify(v));

		  markerListItem.bind('click',markerListClick);
          $('#{/literal}map-{$node.node_id}{literal}').parents('.row').find('.list-markers-text').append(markerListItem);
		});


		var geoJsonLayer = L.geoJson(data, { pointToLayer: function (feature, latlng) {
		  var customIcon = L.MakiMarkers.icon({icon: "star", color: "#f00", size: "l"});
		  var marker = L.marker(latlng, {icon: customIcon});
		  markerMap[feature.id] = marker;
		  return marker;
		} });


		markers.addLayer(geoJsonLayer);
		map.addLayer(markers);
		map.fitBounds(markers.getBounds());
	  });
	  markers.on('click', function (a) {
		$.getJSON("{/literal}{'/openpa/data/map_markers'|ezurl(no)}{literal}?contentType=marker&view=panel&id="+a.layer.feature.id, function(data) {
		  var popup = new L.Popup({maxHeight:360});
		  popup.setLatLng(a.layer.getLatLng());
		  popup.setContent(data.content);
		  map.openPopup(popup);
		});
	  });
	  markerListClick = function(e){
		var id = $(e.currentTarget).data('id');
		var m = markerMap[id];
		markers.zoomToShowLayer(m, function() { m.fire('click');});
		e.preventDefault();
      }
	{/literal}
	</script>
  </div>

  <div class="col-md-12">
    <div class="_list_marker_">
{*        <ul class="list-markers-text list-unstyled" style="height: {$height}px;overflow-y: auto"></ul>*}
        <ul class="list-markers-text list-unstyled list-inline">
    </div>
  </div>

</div>

{*else}

{editor_warning( "Nessuna georeferenza trovata" )}

{/if*}