require_relative '../constants/spotify_constants.rb'
require "http"

include SpotifyConstants

module AyendaRequest
    @access_token

    def self.get_request( endpoint )
        # set_token
        request =  HTTP.headers( :"Content-Type" => "application/x-www-form-urlencoded",:Authorization => "Bearer ".concat( @access_token )  )
                        .get( endpoint )
        return ( JSON.parse request.body.to_s )
    end

    def self.post_request( endpoint, body )
        # set_token
        request =  HTTP.headers( :"Content-Type" => "application/x-www-form-urlencoded",:Authorization => "Bearer ".concat( @access_token )  )
                    .post( endpoint, :form => body )
        return ( JSON.parse request.body.to_s )
    end

    def self.set_token
        request = HTTP.headers( :"Content-Type" => "application/x-www-form-urlencoded",:Authorization => "Basic ".concat( SpotifyConstants::base64_auth )  )
                      .post( SpotifyConstants::token_url, :form => { :grant_type => "client_credentials" }  )
        @access_token =  ( JSON.parse request.body.to_s )["access_token"]
    end

    private 
        def set_token
           request = HTTP.headers( :"Content-Type" => "application/x-www-form-urlencoded",:Authorization => "Basic ".concat( SpotifyConstants::base64_auth )  )
                    .post( SpotifyConstants::token_url, :form => { :grant_type => "client_credentials" }  )
            @access_token =  ( JSON.parse request.body.to_s )["access_token"]
        end
end