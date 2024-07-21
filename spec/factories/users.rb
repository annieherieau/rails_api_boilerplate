FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    password { "123456" }
  end
end