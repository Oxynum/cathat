window.MapManager = {}
map = {}

MapManager.initialize_map_and_messages = (position) ->
	latitude = position.coords.latitude
	longitude = position.coords.longitude
	MapManager.send_info_to_server latitude, longitude
	MapManager.display_map latitude, longitude
	Chat.get_message_list latitude, longitude

MapManager.getLocation = ->
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition MapManager.initialize_map_and_messages, Utils.display_error
	else
	# not supported by the browser
		display_default_error

MapManager.getLocationAndSendMessage = ->
	if navigator.geolocation
		navigator.geolocation.getCurrentPosition Chat.send_message, Utils.display_error
	else
		display_default_error

MapManager.add_marker = (latitude, longitude, author) ->
	position = new google.maps.LatLng(latitude, longitude) 
	marker = new google.maps.Marker({position: position, map: map, title: author})

MapManager.display_map = (latitude, longitude) ->
	mapOptions = { center: new google.maps.LatLng(latitude, longitude), zoom: 13}
	map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions)
	MapManager.add_marker latitude, longitude

MapManager.send_info_to_server = (latitude, longitude) ->
	$.ajax({
		url: 'update_position',
		type: 'PUT',
		data: {latitude: latitude, longitude: longitude} 
		})

google.maps.event.addDomListener(window, 'load', MapManager.getLocation);
