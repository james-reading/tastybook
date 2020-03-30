FactoryBot.define do
  factory :ingredient do
    recipe
    name { 'Eggs' }
  end
end
