FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:email) { |n| "email#{n}@readmatters.com" }
    password 'password'
    confirmed_at 1.day.ago
    created_at 1.day.ago
  end

  factory :complete_user, parent: :user do
    current_location User.current_location.values.sample
    phone "18512341234"
  end
end
