class ApplicationController < ActionController::API
   include ActionController::Serialization

   def serializable_resource(resource)
    ActiveModelSerializers::SerializableResource.new(resource)
   end
end
