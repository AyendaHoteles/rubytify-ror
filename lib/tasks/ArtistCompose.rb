class ArtistCompose

  attr_accessor :object, :id, :albums, :genres

  def initialize(object,id, albums, genres)
      @object = object
      @id = id
      @albums = albums
      @genres = genres
  end 

end 