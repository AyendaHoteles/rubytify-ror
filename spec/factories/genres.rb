FactoryBot.define do

  factory :genre do
    name { Faker::Name.first_name }
  end

end
