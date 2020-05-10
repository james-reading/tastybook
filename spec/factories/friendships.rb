FactoryBot.define do
  factory :friendship do
    user
    friend
    sequence :invitation_email do |n|
      "user-#{n}@local.host"
    end

    trait :accepted do
      accepted_at { Time.now }
    end
  end
end
