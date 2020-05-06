FactoryBot.define do
  factory :friendship do
    user
    friend
    sequence :invitation_email do |n|
      "user-#{n}@local.host"
    end
  end
end
