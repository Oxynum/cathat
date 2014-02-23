class MessagesController < ApplicationController
    before_filter :authenticate_user!

	swagger_controller :users, "Messages Management"
	swagger_api :index do
		summary "Get the last 5 messages in the area specified"
		param :form, :latitude, :string, :required
		param :form, :longitude, :string, :required
	end
    
    def index
        @messages = Message.message_in_area(params[:latitude], params[:longitude], current_user.message_zone).main_information
		render json: @users
    end
end
