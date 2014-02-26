class ChannelsController < ApplicationController
    before_filter :authenticate_user_from_token!
    before_filter :authenticate_user!

    swagger_controller :channels, "User Channels"

    swagger_api :index do
    	summary "Retreive all channels"
    	param :query, 'user[email]', :string, :required
		param :query, 'user[authentication_token]', :string, :required
    end

    swagger_api :show do
    	summary "Retrieve the information of a channel"
    	param :path, :id, :integer, :required
    	param :query, 'user[email]', :string, :required
		param :query, 'user[authentication_token]', :string, :required
    end

    swagger_api :update do
    	summary "Update the position of a channel"
    	param :path, :id, :integer, :required
		param :body, :body, :channel, :required    
	end

	swagger_api :destroy do
		summary "Deletes a channel"
		param :path, :id, :integer, :required
    	param :form, 'user[email]', :string, :required
		param :form, 'user[authentication_token]', :string, :required
	end

	swagger_api :create do 
		summary "Creates a channel"
    	param :form, 'user[email]', :string, :required
		param :form, 'user[authentication_token]', :string, :required
		param :form, 'channel[title]', :string, :required
		param :form, 'channel[longitude]', :float, :required
		param :form, 'channel[latitude]', :float, :required
	end

    swagger_api :add_user do
        description "Add a user to this channel"
        param :path, :id, :integer, :required
        param :form, 'user[email]', :string, :required
        param :form, 'user[authentication_token]', :string, :required
    end

    swagger_api :remove_user do
        description "Remove a user from this channel"
        param :path, :id, :integer, :required
        param :form, 'user[email]', :string, :required
        param :form, 'user[authentication_token]', :string, :required
    end
    
	swagger_model :channel do
		description "The editable information of a channel"
		property :latitude, :float, :optional, "The latitude of a channel"
		property :longitude, :float, :optional, "The longitude of a channel"
		property :creator_id, :integer, :optional, "The id of the owner of the channel"
		property :user, :user_credentials, :required, "The user credentials"
	end

	swagger_model :user_credentials do 
        description "The user login information"
        property :email, :string, :required, "User email"
        property :authentication_token, :string, :required, "User authentication_token"
    end

    def index
    	@channels = Channel.all
		render json: @channels
    end

    def show
    	@channel = Channel.where(id: params[:id]).first
    	render json: @channel
    end

    def update
    	@channel = Channel.where(id: params[:id]).first
    	if current_user == @channel.creator
    		@channel.update_attributes channel_params
    		render json: @channel
    	else
    		render text: "Not authorized", status: 401
    	end
    end	

    def destroy
    	@channel = Channel.where(id: params[:id]).first
    	if current_user == @channel.creator
    		@channel.destroy
    		render text: "success"
    	else
    		render text: "Not authorized", status: 401
    	end
    end	

    def create
    	@channel = Channel.new create_channel_params
    	@channel.creator = current_user
    	@channel.save
    	render json: @channel
    end

    def add_user
        @channel = Channel.where(id: params[:id]).first
        @channel.subscribers << current_user
        @channe.save
        render text: "success", status: 201
    end

    def remove_user
        @channel = Channel.where(id: params[:id]).first
        @channel.subscribers.delete current_user
        @channel.save
        render text: "success"
    end

    private
    def create_channel_params
    	params.require(:channel).permit(:latitude, :longitude, :title)    	
    end

    def channel_params
    	params.require(:channel).permit(:latitude, :longitude, :creator_id)
    end
end
