class Omniauth::SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    render :json=> {:success=>true, :auth_token=>@user.authentication_token, :email=>@user.email, :email_md5 => Digest::MD5.hexdigest(@user.email), :id =>@user.id}
  end
  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end