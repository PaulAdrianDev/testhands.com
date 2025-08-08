FactoryBot.define do
  factory :user do
    username { "SomeUser" }
    email_address { "someone@email.com" }
    password { "password123" }
  end
end