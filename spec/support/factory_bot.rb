require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name { 'first_name' }
    last_name { 'last_name' }
    sequence(:username) { |n| "username#{n}" } 
    password { 'password' }
    password_confirmation { 'password' }
  end
end

FactoryBot.define do
  factory :trip do
    sequence(:name) { |n| "trip#{n}"}
    success {'success'}
    species {'species'}
    body {'body'}
    latitude {0}
    longitude {0}
  end

end
