# frozen_string_literal: true

# Artist serializer class
#
# Its responsibility is to behave like a serializer,
# the model stays intact.
class AlbumSerializer < SimpleDelegator
  def initialize(article, options = {})
    super(article)
    @article = article
    @options = options
  end

  # We don't want to use the `_options`
  # since those are Rails framework stuffs
  # which are out of our control.
  # Instead use the `@options` passed through
  # the serializer initialization phase.
  def as_json(_options = nil)
    super(
      only: %i[id name total_tracks spotify_url],
      include: {
        image: {
          only: %i[height width url]
        }
      }
    ).merge(@options)
  end
end
