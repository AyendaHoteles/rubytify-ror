class ApplicationController < ActionController::API

    def custom_parser( obj )
        {:data => obj}
    end
end
