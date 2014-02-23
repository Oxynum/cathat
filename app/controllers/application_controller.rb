class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

	after_filter :set_access_control_headers

	def set_access_control_headers 
		headers['Access-Control-Allow-Origin'] = '*' 
		headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
		headers['Access-Control-Request-Method'] = '*' 
		headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
		headers['Access-Control-Max-Age'] = "1728000"
	end
  
  def authenticate_user_from_token!
    user_email = params[:user][:email].presence
    user       = user_email && User.find_by_email(user_email)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:user][:authentication_token])
      sign_in user, store: false
    end
  end

end
