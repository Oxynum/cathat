class MessagesController < ApplicationController
    before_filter :authenticate_user!

    def index
        @messages = Message.message_in_area(params[:latitude], params[:longitude], current_user.message_zone).main_information
        respond_to do |format|
          format.html {render layout: false}
		  format.json { render json: @users}
        end
    end
end
