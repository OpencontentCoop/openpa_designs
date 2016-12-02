/*
 * Main script file
 * @version 0.1
 */


$(document).ready(function() {
    if ($('#contacts-map').length) {
        var map = L.map('contacts-map').setView([45.893588, 11.043660], 16);
        L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
            attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
            maxZoom: 18,
            id: 'coppone.kmdj5ggk'
        }).addTo(map);

        L.marker([45.893588, 11.043660]).addTo(map);
    }

});
