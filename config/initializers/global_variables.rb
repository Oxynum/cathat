$connected_users = Hash.new do |h,k|
	h[k] = 0
end

if Rails.env.production?
	$websocket_server_config = {
		port: 3001,
		host: "window.location.host",
		path: "\"/websocket\""
	}
else
	$websocket_server_config = {
		port: 3000,
		host: "\"0.0.0.0\"",
		path: "\"/websocket\""
	}
end