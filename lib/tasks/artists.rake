require 'net/http'

namespace :artists do
  task upload: :environment do
    path = "./artists.yml"
    File.open(path) do |file|
      YAML.load_file(file)["artists"].each do |artist|
        puts "fetching: #{artist}"
        puts "Fetching albums for: #{artist}"
        puts "Fetching songs for: #{artist}"
        puts "Fetching genres for: #{artist}"
      end
    end
  end

  task test: :environment do
    uri = URI('https://accounts.spotify.com/api/token')
    client_id = 'dd06f329d5484973a7916a6066df137a'
    client_secret = '3c816c1a52664905a6a5052e6cd4f90e'
    key_base64 = Base64.strict_encode64("#{client_id}:#{client_secret}")
    params = { grant_type: 'client_credentials' }
    headers = { 
      "Authorization": "Basic #{key_base64}",
      "Content-Type": 'application/x-www-form-urlencoded'
    }
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.path)
    headers.each {|k,v| request[k] = v }

    request.set_form_data(params)

    response = https.request(request)
    puts response.body
  end
end
