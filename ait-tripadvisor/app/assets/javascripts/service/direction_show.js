// This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.
var directionsDisplay
function initialize_show() {

  var markers = [];
  var map
  var directionsService = new google.maps.DirectionsService();
  directionsDisplay = new google.maps.DirectionsRenderer();;

  var origin = $('#map-canvas-show').data('origin');
  var destination = $('#map-canvas-show').data('destination');
  var transportation = $('#map-canvas-show').data('transportation');

  var start = new google.maps.LatLng(origin.lat, origin.lng);
  var end = new google.maps.LatLng(destination.lat, destination.lng);
  var mode
  if(transportation.type == "Taxi"){
    mode = google.maps.TravelMode.DRIVING
  } else if(transportation.type == "Bicycle") {
    mode = google.maps.TravelMode.BICYCLING
  } else if(transportation.type == "Bus") {
    mode = google.maps.TravelMode.TRANSIT
  }

  var mapOptions = {
    zoom: 16,
    center: start,
  };
  map = new google.maps.Map(document.getElementById('map-canvas-show'), mapOptions);
  directionsDisplay.setMap(map);
  directionsDisplay.setPanel(document.getElementById('directions-panel'));

  var request = {
    origin:start,
    destination:end,
    travelMode: mode
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    } else {
      //In case google map cannot return any direction
      $('#map-canvas-show').parent().html($('<div></div>').attr('class','alert alert-danger').html("Sorry, Google map unavailable for this direction"))

    }
  });



}



$(function () {
  if($('#map-canvas-show').length > 0) {
    google.maps.event.addDomListener(window, 'load', initialize_show);
  }

  $('#route_detail').on('click', '.adp-directions tbody tr', function(event) {
    $(this).addClass('highlight').siblings().removeClass('highlight');
  });

  // $('body').css("background-color",$(".navbar-collapse ul li.active :first").css('background-color'))
});
