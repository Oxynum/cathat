class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
  	params.require(:user).permit(:gender, :pseudo, :email, :birth_date, :first_name, :last_name, :password, :password_confirmation)
  end

end