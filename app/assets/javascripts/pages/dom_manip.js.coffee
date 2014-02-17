window.DOM = {}
DOM.add_message = (message) ->
	$('#messages_list').prepend $("
		<div class=\"email\">#{message.email}</div>
		<div class=\"body\">#{message.body}</div>
		<div class=\"created_at\">#{message.created_at}</div>
		<div class=\"latitude\">#{message.latitude}</div>
		<div class=\"longitude\">#{message.longitude}</div>
	")

DOM.initialize_body_textarea = () ->
	$("#message_body").keyup (event) ->
		event.preventDefault()
		body = $("#message_body").val()
		body = body.trim()
		if event.keyCode == 13 && body
			MapManager.getLocationAndSendMessage()

google.maps.event.addDomListener(window, 'load', DOM.initialize_body_textarea);
dispatcher.bind 'message_received', DOM.add_message