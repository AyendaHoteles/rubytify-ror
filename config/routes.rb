Rails.application.routes.draw do
  mount OkComputer::Engine, at: '/check_health'
  mount API::Base, at: '/api'
  mount GrapeSwaggerRails::Engine, at: '/apidoc'
end

# == Route Map
#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#                okcomputer      /okcomputer                                                                              OkComputer::Engine
#               ok_computer      /check_health                                                                            OkComputer::Engine
#                  api_base      /api                                                                                     API::Base
#       grape_swagger_rails      /apidoc                                                                                  GrapeSwaggerRails::Engine
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
# 
# Routes for OkComputer::Engine:
#              root GET|OPTIONS /                 ok_computer/ok_computer#show {:check=>"default"}
# okcomputer_checks GET|OPTIONS /all(.:format)    ok_computer/ok_computer#index
#  okcomputer_check GET|OPTIONS /:check(.:format) ok_computer/ok_computer#show
# 
# Routes for GrapeSwaggerRails::Engine:
#   root GET  /           grape_swagger_rails/application#index
