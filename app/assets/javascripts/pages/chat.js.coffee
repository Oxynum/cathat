window.Chat = {}

window.dispatcher = new WebSocketRails('0.0.0.0:3000/websocket')
latitude= 0
longitude = 0
dispatcher.on_open = (data) ->
  console.log 'Connection has been established'

Chat.create_location_message = (latitude, longitude) ->
	{latitude: latitude, longitude: longitude, body: $('#message_body').val().trim()}

Chat.get_message_list = (latitude, longitude) ->
	$.get "messages", {latitude: latitude, longitude: longitude}, (data) ->
		$("#messages_list").html(data)

Chat.send_message = (position) ->
	message = Chat.create_location_message(position.coords.latitude, position.coords.longitude)
	MapManager.send_info_to_server position.coords.latitude, position.coords.longitude
	dispatcher.trigger 'message_received', message
	$('#message_body').val("")