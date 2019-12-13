class ImportArtistTxt
  def get_artist
    file = Rails.root.join("db", "seeds", "artists.txt")
    artists = []
    File.readlines(file).each do |line|
      artists << line
    end
  end
end
