class UsersController < ApplicationController

    before_filter :authenticate_user!

    swagger_controller :users, "User Management"

    swagger_api :index do 
        summary "Fetches the list of all connected users (id, email, latitude, longitude)"
        param :path, :nothing, :string, :optional
        response :unauthorized
        response :not_acceptable
    end
    swagger_api :update do 
        summary "Change the latitude and longitude of a user"
        param :path, :id, :integer, :required, "User Id"
        param :form, 'user[latitude]', :string, :optional
        param :form, 'user[longitude]', :string, :optional
        response :unauthorized
        response :not_acceptable
    end

    def update
        if User.where(id: params[:id]).first.update_attributes user_params
            render nothing: true
        else
            render nothing: true, status: 304
        end
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
