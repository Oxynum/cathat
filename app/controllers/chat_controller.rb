class ChatController < WebsocketRails::BaseController
  before_filter :ensure_logged_in!

  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def message_received
    p 'toto'
  	broadcast_message 'message_received', message
  end

  def connect
    current_user.connect!
    $connected_users[current_user.id]+=1
  end

  def disconnect
    $connected_users[current_user.id]-=1
    current_user.disconnect! if $connected_users[current_user.id] == 0
  end

  private
  def ensure_logged_in!
  	if current_user.nil?
  		trigger_failure({error: "The user is not logged in."})
  	end
  end
end