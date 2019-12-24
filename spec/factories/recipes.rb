FactoryBot.define do
  factory :recipe do
    user
    name { 'Cottage pie' }
    length { 'Long' }
    cuisine
  end
end
