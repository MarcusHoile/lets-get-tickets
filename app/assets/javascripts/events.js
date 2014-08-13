function selectThisEvent(selection) {
	// grab the information from selected event
	// and insert it into form inputs
	var what = selection.find('.event-list-name').text();
	var when = selection.find('.event-list-date').text();
	var where = selection.find('.event-list-venue').text();
	var lat = selection.find('.event-lat').text().trim();
	var lng = selection.find('.event-lng').text().trim();
	// var latlng = { lat: parseFloat(lat), lng: parseFloat(lng)}


	$('#event_what').val(what.trim());
	$('#event_where').val(where.trim());
	$('#event_event_when_text').val(when.trim());
	$('#event_lat').val(parseFloat(lat));
	$('#event_lng').val(parseFloat(lng));
}

function mapInit(lat, lng){
  var mapCanvas = document.getElementById("map-canvas");
  var latLng = new google.maps.LatLng(lat, lng);
  var mapOptions = {
    center: latLng,
    mapTypeControl: false,
    panControl: false,
    zoomControl: false,
    streetViewControl: false,
    zoom: 12
  };

  // create a map
  var map = new google.maps.Map(mapCanvas, mapOptions);
  // add a marker
  var marker = new google.maps.Marker({
    map: map,
    position: latLng
  });
}

jQuery.fn.submitOnCheck = function() {
  this.find('input[type=submit]').remove();
  return this;
}


$(function() {
  // payment tracking and ticket purhcase confirmation
  $('.edit_invite').submitOnCheck();
  $('.edit_event').submitOnCheck();
  $('.onoffswitch-label').on('click', function(){
    var checkBox = $(this).prev('input')
    var val = checkBox.is(':checked');
    checkBox.prop('checked', !val);
    $(this).parent('form').submit();
  });
  $('.ticket-confirm').on('click', function(){
    $(this).parent('form').submit();
  })

  

});

