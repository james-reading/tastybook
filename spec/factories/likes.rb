FactoryBot.define do
  factory :like do
    user
    likeable { association(:recipe) }
  end
end
