# frozen_string_literal: true

# Not found handler module
#
# Responsible for handling errors caused by
# records that could not be found.
module NotFoundHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      render json: { error: I18n.t('not_found') }, status: :not_found
    end
  end
end
