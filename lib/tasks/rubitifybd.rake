require 'rspotify'
require 'yaml'

namespace :rubitifybd do
  desc "TODO"
  task get_info: :environment do
    Rake::Task['rubitifybd:reset'].invoke

    RSpotify.authenticate('7a95fae7bab84a4fa6bffa3538fdcb81', 'c769686256bc438cac85bf25290c010f')
  end
end
