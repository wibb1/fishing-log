require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name { 'first_name' }
    last_name { 'last_name' }
    username {'username'}
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
    trip_date {'trip_date'}
    trip_time {'trip_time'}
  end

end
