class ApplicationController < ActionController::API
    def render_resources(resources, options, status: :ok)
        render json: { data: resources.as_json(only: options) }, status: status
      end
end
