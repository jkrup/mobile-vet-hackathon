window.on_map = [];

function initialize_google_maps() {
        var g = new google.maps.Geocoder();

        addrs = [];

        visits = $(".visit-address-data");
        requests = $(".request-address-data");

       for (var i = 0; i < visits.length; ++i) {
         addrs.push(visits[i].getAttribute("data-address"));
       } 

        if (addrs.length > 0) {
          g.geocode( {'address': addrs[0]}, function(r,s) {
              var mapOptions = {
                center: r[0]['geometry']['location'],
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP
              };
              window.map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions); 
              window.bounds = new google.maps.LatLngBounds();
              window.markers = []

          for(var i = 0; i < addrs.length; ++i) {
              addToMap(addrs[i])
            }
          });

          for (var i = 0; i < requests.length; ++i) {
              addToMapLater(requests[i].getAttribute("data-address"));
           }
        }
        else {
          var mapOptions = {
                center: new google.maps.LatLng(29.6492, -82.3243),
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP
              };
              window.map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions); 
              window.bounds = new google.maps.LatLngBounds();
              window.markers = []

          for (var i = 0; i < requests.length; ++i) {
            addToMapLater(requests[i].getAttribute("data-address"));
          }
        }

}


function refitMap() {
  window.bounds = new google.maps.LatLngBounds();
  
  if(window.markers.length <= 0) {
    window.map.setCenter(new google.maps.LatLng(29.6492, -82.3243));
    window.map.setZoom(15);
  }
  else if(window.markers.length <= 1) {
    window.map.setCenter(window.markers[0].getPosition());
    window.map.setZoom(15);
  }
  else {
    for(var i = 0; i < window.markers.length; ++i) {
      window.bounds.extend(window.markers[i].getPosition()); 
    }
    window.map.fitBounds( window.bounds );
  }
}

function addToMap(address) {
    new google.maps.Geocoder().geocode( {'address': address}, function(res, code) {
        marker = new google.maps.Marker({
          position: res[0]['geometry']['location'],
          map: window.map 
        });
        window.markers.push(marker);
        marker.setIcon("http://maps.google.com/mapfiles/ms/icons/green-dot.png");

        refitMap();
      });
}

function addToMapLater(address) {
    new google.maps.Geocoder().geocode( {'address': address}, function(res, code) {
        marker = new google.maps.Marker({
          position: res[0]['geometry']['location'],
          map: window.map 
        });
        window.markers.push(marker);
        marker.setIcon("http://maps.google.com/mapfiles/ms/icons/red-dot.png");

        refitMap();
      });
}

function removeLastFromMap() {
  window.markers.pop().setMap(null);
  refitMap();
}
