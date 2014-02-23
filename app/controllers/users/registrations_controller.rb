class Users::RegistrationsController < Devise::RegistrationsController

  swagger_controller :users_registrations, "User Registration"
  swagger_api :create do
  	param :form, :gender, :string, :optional
  	param :form, :email, :string, :required
  	param :form, :pseudo, :string, :required
  	param :form, :birth_date, :string, :required
  	param :form, :first_name, :string, :optional
  	param :form, :last_name, :string, :optional
  	param :form, :password, :string, :required
  	param :form, :password_confirmation, :string, :required
  end

  private

  def sign_up_params
  	params.require(:user).permit(:gender, :pseudo, :email, :birth_date, :first_name, :last_name, :password, :password_confirmation)
  end

end