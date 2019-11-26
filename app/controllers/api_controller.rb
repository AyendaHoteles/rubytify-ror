class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(error)
    render json: { errors: [error] }, status: :not_found
  end
end
