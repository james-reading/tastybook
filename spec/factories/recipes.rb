FactoryBot.define do
  factory :recipe do
    user
    name { 'Cottage pie' }
    length { 'Medium' }
    course { 'Main' }
  end
end
