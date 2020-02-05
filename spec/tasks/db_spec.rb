require 'rake'

RSpec.describe "db:spotify" do
  before do
    file, path = Rake.application.find_rakefile_location
    Rake.load_rakefile("#{path}/#{file}")
  end

  let(:artists) {Artist.all}
  let(:albums) {Album.all}

  it "doesn't have to have any record" do
    Artist.delete_all
    Album.delete_all
    expect(artists.count).to be 0
    expect(albums.count).to be 0
    expect(albums.first).to be nil

  end

  it "has to get the albums from spotify" do
    Rake.application["db:artists"].invoke
    expect(artists.count).to be 23
  end

  it "has to get the albums from spotify" do
    Rake.application["db:albums"].invoke
    expect(albums.first).to_not be nil
  end
end
