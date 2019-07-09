module API
  module Entities
    class ApiError < Grape::Entity
      expose :code
      expose :message
    end
  end
end
