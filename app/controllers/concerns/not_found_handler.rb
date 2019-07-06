module NotFoundHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      render json: { error: I18n.t('not_found') }, status: :not_found
    end
  end
end