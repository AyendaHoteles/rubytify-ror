require "spec_helper"
require "rails_helper"
require "rake"

# Mocks
class SpotifyMock
    def set_artists
        puts "calling artists"
    end
    def set_albums
        puts "calling albums"
    end
    def set_songs
        puts "calling songs"
    end
end
#  ......................

describe "spotify:fetch" do 
    before :all do
        Rake.application.rake_require 'tasks/spotify'
        Rake::Task.define_task(:environment)

        @spotifyMock = SpotifyMock.new
    end

    describe 'test rake task' do
        let :run_rake_task do
            Rake::Task['spotify:fetch'].reenable
            Rake.application.invoke_task 'spotify:fetch'
        end

        it '01 Should call Spotify functions correctly' do
            #  GIVEN
            mySpy = spy(@spotifyMock)
            allow( Spotify ).to receive( :new ).and_return ( mySpy )
            allow( YAML ).to receive( :load ).and_return ( {:artist => ["art1","art2"]})

            #  WHEN
            run_rake_task
            
            # THEN
            expect( mySpy ).to have_received(:set_artists)
            expect( mySpy ).to have_received(:set_albums)
            expect( mySpy ).to have_received(:set_songs)
        end
    end
end