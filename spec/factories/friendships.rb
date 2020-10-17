FactoryBot.define do
  factory :friendship do
    user
    sequence :invitation_email do |n|
      "invite-#{n}@local.host"
    end

    trait :pending do
      accepted_at { nil }
    end

    trait :accepted do
      friend

      after(:create) do |friendship|
        friendship.accept!
      end
    end
  end
end
