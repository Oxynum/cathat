class Users::RegistrationsController < Devise::RegistrationsController

  # swagger_controller :users_registrations, "User Registration"
  # swagger_api :create do
  # 	param :form, 'user[gender]', :string, :optional
  # 	param :form, 'user[email]', :string, :required
  # 	param :form, 'user[pseudo]', :string, :required
  # 	param :form, 'user[birth_date]', :date, :required
  # 	param :form, 'user[first_name]', :string, :optional
  # 	param :form, 'user[last_name]', :string, :optional
  # 	param :form, 'user[password]', :string, :required
  # 	param :form, 'user[password_confirmation]', :string, :required
  #   summary "Create a user"
  #   response :not_acceptable
  # end

  def create
    user = User.new(sign_up_params)
    if user.save
      render :json=> user, :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

  private

  def sign_up_params
  	params.require(:user).permit(:gender, :pseudo, :email, :birth_date, :first_name, :last_name, :password, :password_confirmation)
  end

end
