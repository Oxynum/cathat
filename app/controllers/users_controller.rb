class UsersController < ApplicationController

    before_filter :authenticate_user!

    def update_position
        current_user.update_attributes user_params
        render nothing: true
    end

    def connected
    	@users = User.connected.select(:id, :email, :latitude, :longitude)
        render json: @users
    end

    private

    def user_params
        params.permit :latitude, :longitude
    end

end
