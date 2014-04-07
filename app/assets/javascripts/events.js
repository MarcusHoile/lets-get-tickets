function selectThisEvent(selection) {
	// grab the information from selected event
	// and insert it into form inputs
	var what = selection.find('.event-list-name').text();

	$('#event_what').val(what.trim());
}