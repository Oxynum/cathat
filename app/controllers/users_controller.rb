class UsersController < ApplicationController

    before_filter :authenticate_user_from_token!
    before_filter :authenticate_user!

    swagger_controller :users, "User Management"

    swagger_api :index do 
        summary "Fetches the list of all connected users (id, email, latitude, longitude)"
        param :query, 'user[email]', :string, :required
        param :query, 'user[authentication_token]', :string, :required
        response :unauthorized
        response :not_acceptable
    end
    swagger_model :user_position do 
        description "Describe the current position of a user"
        property :user, :user_credentials, :required, "The user credentials"
        property :latitude, :float, :optional, "The latitude of the user"
        property :longitude, :float, :optional, "The longitude of the user"
    end
    swagger_model :user_credentials do 
        description "The user login information"
        property :email, :string, :required, "User email"
        property :authentication_token, :string, :required, "User authentication_token"
    end
    swagger_api :update do 
        summary "Change the latitude and longitude of a user"
        param :path, :id, :integer, :required
        param :body, :body, :user_position, :required
        response :unauthorized
        response :not_acceptable
    end

    swagger_api :show do
        summary "Get the information of a user"
        param :path, :id, :integer, :required
        param :query, 'user[email]', :string, :required
        param :query, 'user[authentication_token]', :string, :required
    end

    swagger_api :subscribe_to_channel do
        summary "Subscribe to the channel whose id is specified"
        param :form, 'user[email]', :string, :required
        param :form, 'user[authentication_token]', :string, :required
        param :form, 'channel[id]', :integer, :required
        response :unauthorized
        response :not_acceptable
    end

    swagger_api :unsubscribe_from_channel do
        summary "Subscribe to the channel whose id is specified"
        param :form, 'user[email]', :string, :required
        param :form, 'user[authentication_token]', :string, :required
        param :form, 'channel[id]', :integer, :required
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

    def show 
        render json: User.where(id: params[:id]).first
    end

    def subscribe_to_channel
        current_user.channels << Channel.where(id: params[:channel][:id]).first
        current_user.save
        render text: "success", status: 201
    end

    def unsubscribe_from_channel
        current_user.channel.delete Channel.where(id: params[:channel][:id]).first
        current_user.save
        render text: "success"
    end

    private

    def user_params
        params.require(:user).permit :email, :authentication_token, :latitude, :longitude
    end

end
