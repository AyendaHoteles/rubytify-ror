class BaseSerializer < ActiveModel::Serializer
  attributes(:name, :spotify_url)
end
