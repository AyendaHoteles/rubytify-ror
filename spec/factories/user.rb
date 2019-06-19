FactoryBot.define do
  factory :user, class: User do
    name {Faker::Name.first_name}
    email {Faker::Internet.email}
   
    factory :admin_user, class: AdminUser do
      password  "emprendimiento"
      password_confirmation "emprendimiento"
    end
  end
end