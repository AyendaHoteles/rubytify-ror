class ApplicationController < ActionController::API
  def build_response(data, serializer)
    {
      data: ActiveModelSerializers::SerializableResource.new(
        data, each_serializer: serializer
      )
    }
  end
end
