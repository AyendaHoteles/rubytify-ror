class ApplicationController < ActionController::API
  def data_wrapper(data)
    ActiveModelSerializers::SerializableResource.new(data)
  end
end
