// This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.
function checkEnter(e){
  e = e || event;
  var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
  return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
}

function initialize() {

  var markers = [];
  var map = new google.maps.Map(document.getElementById('map-canvas'), {
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var defaultBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(14.079371, 100.612777),
    new google.maps.LatLng(14.081971, 100.612777)
  );
  map.fitBounds(defaultBounds);

  // Create the search box and link it to the UI element.
  var input = /** @type {HTMLInputElement} */(
    //document.getElementById('pac-input')
      document.getElementById('place_name')
  );
   // var searchBox = new google.maps.places.SearchBox((input));
    var searchBox = new google.maps.places.SearchBox((input));
  //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  /** @type {HTMLInputElement} */


  // [START region_getplaces]
  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  google.maps.event.addListener(searchBox, 'places_changed', function() {
    var places = searchBox.getPlaces();
   // alert(places.length);
    if (places.length == 0) {
      return;
    }
    for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }

    // For each place, get the icon, place name, and location.
    markers = [];
    console.log(places[0])
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0, place; place = places[i]; i++) {
      var image = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };
       ////////////////For nearby search///////////////////////////////////

        //service.nearbySearch(request, callback);
        /////////////////////////End/////////////////////////////////////

      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map: map,
        title: place.name,
        position: place.geometry.location,
        draggable:true,
        icon: "http://www.sanwebe.com/assets/google-map-markers-infowindows/icons/pin_green.png" //custom pin icon
      });

      setMarkerInfo(marker)
      setLatLng(marker)
      google.maps.event.addListener(marker, "dragend", function(event){
        setLatLng(marker)
      });

      markers.push(marker);
      bounds.extend(place.geometry.location);
    }

    map.fitBounds(bounds);
    var listener = google.maps.event.addListener(map, "idle", function() {
      if (map.getZoom() > 16) map.setZoom(16);
      google.maps.event.removeListener(listener);
    });
  });
  // [END region_getplaces]

  // Bias the SearchBox results towards places that are within the bounds of the
  // current map's viewport.
  google.maps.event.addListener(map, 'bounds_changed', function() {
    var bounds = map.getBounds();
    searchBox.setBounds(bounds);
  });


  //##### drop a new marker on right click ######
  google.maps.event.addListener(map, 'rightclick', function(event) {
    for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }
    markers = [];
    var marker = new google.maps.Marker({
      position: event.latLng, //map Coordinates where user right clicked
      map: map,
      draggable:true, //set marker draggable
      animation: google.maps.Animation.DROP, //bounce animation
      title:"Your custom mark",
      icon: "http://www.sanwebe.com/assets/google-map-markers-infowindows/icons/pin_green.png" //custom pin icon
    });
    markers.push(marker);
    setMarkerInfo(marker)
    setLatLng(marker)
    google.maps.event.addListener(marker, "dragend", function(event){
      setLatLng(marker)
    });
  });



  function setMarkerInfo(marker){
    //Content structure of info Window for the Markers
    var contentString = $('<div class="marker-info-win">'+
    '<div class="marker-inner-win"><span class="info-content">'+
    '<h1 class="marker-heading">' + ($('#place_name').val()||marker.title||'New Marker') + '</h1>'+
    ($('#place_description').val()||' ') +
    '</span>'+
    '</div></div>');

    //Create an infoWindow
    var infowindow = new google.maps.InfoWindow();

    //set the content of infoWindow
    infowindow.setContent(contentString[0]);

    //add click event listener to marker which will open infoWindow
    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker); // click on marker opens info window
    });
  }

  function setLatLng(marker){
    $('#place_lat').val(marker.getPosition().k)
    $('#place_lng').val(marker.getPosition().B)
  }

}

function initialize_show() {

  var markers = [];
  var map
  var mLatLng = new google.maps.LatLng($('#map-canvas-show').data('lat'), $('#map-canvas-show').data('lng'));
  var name = $('#place_name').text();
  var desc = $('#place_desc').text();
  var mapOptions = {
    zoom: 16,
    center: mLatLng
  };
  map = new google.maps.Map(document.getElementById('map-canvas-show'), mapOptions);


  var marker = new google.maps.Marker({
    position: mLatLng,
    map: map,
    title: name
  });
  setMarkerInfo(marker)

  function setMarkerInfo(marker){
    //Content structure of info Window for the Markers
    var contentString = $('<div class="marker-info-win">'+
    '<div class="marker-inner-win"><span class="info-content">'+
    '<h1 class="marker-heading">' + ($('#place_name').val()||marker.title||'New Marker') + '</h1>'+
    (desc||' ') +
    '</span>'+
    '</div></div>');

    //Create an infoWindow
    var infowindow = new google.maps.InfoWindow();

    //set the content of infoWindow
    infowindow.setContent(contentString[0]);

    //add click event listener to marker which will open infoWindow
    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker); // click on marker opens info window
    });
  }

}

$(function () {
  if($('#map-canvas').length != 0) {

    google.maps.event.addDomListener(window, 'load', initialize);

    //google.maps.event.addDomListener(window, 'load', nearPlaces);
    document.querySelector('form').onkeypress = checkEnter;
  } else if($('#map-canvas-show').length > 0) {
     nearPlaces(map);
    google.maps.event.addDomListener(window, 'load', initialize_show);

  }

  // $('body').css("background-color",$(".navbar-collapse ul li.active :first").css('background-color'))
});
