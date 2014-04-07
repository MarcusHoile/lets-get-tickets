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