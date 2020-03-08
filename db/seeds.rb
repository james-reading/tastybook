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


# create some random recipes
cuisine_count = Cuisine.count
user = User.last

500.times do
  name = begin
    n = rand
    if n > 0.66
      "#{FFaker::Food.vegetable} and #{FFaker::Food.fruit}"
    elsif n > 0.33
      "#{FFaker::Food.meat} pie"
    else
      FFaker::Food.ingredient
    end
  end

  cuisine = Cuisine.offset(rand(cuisine_count)).first

  Recipe.find_or_initialize_by(name: name).tap do |recipe|
    recipe.cuisine = cuisine
    recipe.user = user
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.link = 'https://www.bbcgoodfood.com/recipes/cottage-pie'

    recipe.save!
    pp "Created #{name}"
  end
end
