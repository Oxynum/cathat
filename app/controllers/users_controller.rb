class UsersController < ApplicationController

    before_filter :authenticate_user!

    def update
        User.where(id: params[:id]).first.update_attributes user_params
        render nothing: true
    end

    def index
    	@users = User.connected.select(:id, :email, :latitude, :longitude)
        render json: @users
    end

    private

    def user_params
        params.permit :latitude, :longitude
    end

end
