class ChatController < WebsocketRails::BaseController
  # before_filter :ensure_logged_in!

  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def message_received
    current_user.users_in_area(50).pluck(:id).each do |id| 
      WebsocketRails["user_#{id}"].trigger 'message_received', message
    end
  end

  def connect
    #What to do when the user connects
  end

  def disconnect
    #And when he disconnects (maybe informing other users ?)
  end

  def create_user_channel
    channel = WebsocketRails['user_#{current_user.id}'].make_private
  end

  def authorize_channels
    channel = WebsocketRails[message[:channel]]
    if channel.name.split('_')[1] == current_user.id
      accept_channel
    else
      deny_channel message: "Authorization failed"
    end
  end

  def private_message
    WebsocketRails['user_' + message[:user_id]].trigger('message_received', message[:message])
  end

  private
  def ensure_logged_in!
    if message.respond_to?(:[]) && message[:token]
      authenticate_user_from_token! message[:token]
      message.delete :token
    end
  	if current_user.nil?
  		trigger_failure({error: "The user is not logged in."})
      raise "Not authorized"
  	end
  end

end