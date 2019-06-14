class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def authenticate_admin
    @auth_token = AuthenticateAdmin.new(auth_params).call
    @current_user = AuthorizeAdminApiRequest.new('Authorization' => @auth_token).call[:user]
    render :authenticate
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
