window.Utils = {}
Utils.display_default_error = ->
	message = "An unknown error occurred."

Utils.display_error = (error) ->
	switch error.code
		when error.PERMISSION_DENIED
			message = "User denied the request for Geolocation."
		when error.POSITION_UNAVAILABLE
			message = "Location information is unavailable."
		when error.TIMEOUT
			message = "The request to get user location timed out."
		when error.UNKNOWN_ERROR
			message = "An unknown error occurred."

Utils.handle_error = (error) ->
	console.log error
