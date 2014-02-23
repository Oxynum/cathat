class Users::SessionsController < Devise::SessionsController

	prepend_before_filter :require_no_authentication, :only => [:create ]
	before_filter :authenticate_user_from_token!
    before_filter :authenticate_user!
	before_filter :ensure_params_exist

	swagger_controller :users_sessions, "User Session"
	swagger_api :create do
	  	param :form, 'user[email]', :string, :required
	  	param :form, 'user[password]', :string, :required
	    summary "Create a new session for the user whose email is specified"
	    response :not_acceptable
  	end

  	swagger_api :destroy do
  		param :form, 'user[email]', :string, :required
        param :form, 'user[authentication_token]', :string, :required
  		summary "Delete the user sessions"
  	end

	def create
	    resource = User.find_for_database_authentication(:email=>params[:user][:email])
	    return invalid_login_attempt unless resource
	 
	    if resource.valid_password?(params[:user][:password])
	      sign_in("user", resource)
	      resource.change_token
	      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
	      return
	    end
	    invalid_login_attempt
 	end

 	def destroy
    	sign_out(resource_name)
    	resource.change_token
  	end


	protected
	def ensure_params_exist
		return unless params[:user].blank?
		render :json=>{:success=>false, :message=>"missing user parameter"}, :status=>422
	end

	def invalid_login_attempt
    	warden.custom_failure!
    	render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
	end

end
