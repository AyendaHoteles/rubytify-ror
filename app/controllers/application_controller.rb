class ApplicationController < ActionController::API

   def index
      render html: "hello, world!"
   end
end
