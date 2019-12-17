# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cuisines = [
  'American',
  'Hawaiian',
  'Indonesian',
  'North African',
  'Australian',
  'Brazilian',
  'Cajun & Creole',
  'Caribbean',
  'Chilean',
  'Chinese',
  'Cuban',
  'Danish',
  'English',
  'French',
  'German',
  'Greek',
  'Indian',
  'Irish',
  'Japanese',
  'Korean',
  'Mediterranean',
  'Mexican',
  'Jewish',
  'Middle Eastern',
  'Moroccan',
  'Portuguese',
  'Scottish',
  'Southern & Soul',
  'Southwestern',
  'Spanish',
  'Swedish',
  'Thai',
  'Turkish',
  'Vietnamese',
  'British',
  'Belgian',
  'Balinese',
  'Italian',
  'Hungarian',
  'Swiss',
  'Tunisian',
  'Asian',
  'Eastern European',
  'Dutch',
  'African',
  'Latin American',
  'Scandinavian',
  'Austrian'
]

i = 0
cuisines.each do |name|
  cuisine = Cuisine.find_or_initialize_by(name: name)

  if cuisine.new_record? && cuisine.save
    i += 1
  end
end
puts "Cuisines created: #{i}"
