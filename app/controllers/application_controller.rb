class ApplicationController < ActionController::API

  def serializable_data(data)
    ActiveModelSerializers::SerializableResource.new(data)
  end
  
end
