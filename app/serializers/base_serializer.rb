class BaseSerializer < ActiveModel::Serializer
  def root
    'data'
  end
end
