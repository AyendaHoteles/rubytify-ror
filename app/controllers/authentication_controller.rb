# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  skip_before_action :authorize_request, only: %i[authenticate authenticate_admin]
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def authenticate_admin
    auth_token = AuthenticateAdmin.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private
  
  def auth_params
    params.permit(:email, :password)
  end
end
