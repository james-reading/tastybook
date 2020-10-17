FactoryBot.define do
  factory :comment do
    user
    recipe
    body { "MyText" }
  end
end
