class ApplicationController < ActionController::API
  def rendering(resource, option, status: :ok)
    render json: { data: resource.as_json(only: option) }, status: status
  end
end
