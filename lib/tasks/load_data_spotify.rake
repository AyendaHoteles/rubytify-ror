namespace :load_data do

	desc "Load Artist from spotify"
	task load_data_spotify: :environment do
		artists = YAML.load_file("#{Rails.root}/artists.yml")

    artists['artists'].each {|artist|

			LoadDataArtistJob.perform_now(artist)
    }
	end

end
