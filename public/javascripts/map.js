var map;
var googlemaps = {
  initMap: function() {
    if (!document.getElementById('map')) {
      return;
    }
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 37.0902, lng: -95.7129},
      scrollwheel: false,
      zoom: 3
    });
    var park, parks = $('body').data('parks');

    var newMarker = function(park) {
      new google.maps.Marker({
        position: { lat: parseFloat(park.lat), lng: parseFloat(park.lng) },
        map: map,
        animation: google.maps.Animation.DROP,
        title: title
      });
    };

    for (var i = 0; i < parks.length; i++) {
      park = parks[i];

      var infowindow = new google.maps.InfoWindow({
        content: "<a href='#"+park.title+"' style='font-size: 10px'>"+park.title+"</span>",
        position: { lat: parseFloat(park.lat), lng: parseFloat(park.lng) },
      });
      infowindow.open(map);
    }
  }
}
