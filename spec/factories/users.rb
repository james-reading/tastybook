FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "user-#{n}"
    end
    sequence :email do |n|
      "user-#{n}@local.host"
    end
    password { 'passw0rd' }
    password_confirmation { 'passw0rd' }
  end
end
