class UsersController < ApplicationController

    def update_position
        current_user.update_attributes user_params
        render nothing: true
    end

    def connected
    	User.connected.select(:id, :email, :latitude, :longitude)
    end

    private

    def user_params
        params.permit :latitude, :longitude
    end

end
