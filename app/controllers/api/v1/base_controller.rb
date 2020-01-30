class Api::V1::BaseController < ActionController::API
  rescue_from StandardError,                with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def bad_request
    render status: :bad_request, body: ''
  end

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def internal_server_error(exception)
    response = if Rails.env.development?
                 {
                   type: exception.class.to_s,
                   message: exception.message,
                   backtrace: exception.backtrace
                 }
               else
                 { error: 'Internal Server Error' }
               end
    render json: response, status: :internal_server_error
  end
end
