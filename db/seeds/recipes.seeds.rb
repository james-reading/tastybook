after :cuisines, :users do

  james = User.find_by_username!('James')
  holly = User.find_by_username!('Holly')

  Recipe.find_or_initialize_by(name: 'Cottage pie').tap do |recipe|
    recipe.cuisine = Cuisine.find_by_name!('English')
    recipe.user = james
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.link = 'https://www.bbcgoodfood.com/recipes/cottage-pie'
    recipe.image.attach(io: File.open(Rails.root.join('lib', 'assets', 'seed_images', 'cottage-pie.jpg')), filename: 'image.jpg')
    recipe.save!
  end

  Recipe.find_or_initialize_by(name: 'Spagetti Bolegnaise').tap do |recipe|
    recipe.cuisine = Cuisine.find_by_name!('Italian')
    recipe.user = james
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.link = 'https://www.bbcgoodfood.com/recipes/best-spaghetti-bolognese-recipe'
    recipe.image.attach(io: File.open(Rails.root.join('lib', 'assets', 'seed_images', 'spaghetti-bolognese.jpg')), filename: 'image.jpg')
    recipe.save!
  end

  Recipe.find_or_initialize_by(name: 'Carbonara').tap do |recipe|
    recipe.cuisine = Cuisine.find_by_name!('Italian')
    recipe.user = james
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.image.attach(io: File.open(Rails.root.join('lib', 'assets', 'seed_images', 'carbonara.jpg')), filename: 'image.jpg')
    recipe.save!
  end

  Recipe.find_or_initialize_by(name: 'Jambalaya').tap do |recipe|
    recipe.cuisine = Cuisine.find_by_name!('Cajun & Creole')
    recipe.user = james
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.image.attach(io: File.open(Rails.root.join('lib', 'assets', 'seed_images', 'jambalaya.jpg')), filename: 'image.jpg')
    recipe.save!
  end

  Recipe.find_or_initialize_by(name: 'Jerk chicken').tap do |recipe|
    recipe.cuisine = Cuisine.find_by_name!('Cajun & Creole')
    recipe.user = james
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.image.attach(io: File.open(Rails.root.join('lib', 'assets', 'seed_images', 'jerk-chicken.jpg')), filename: 'image.jpg')
    recipe.save!
  end

  Recipe.find_or_initialize_by(name: 'Ramen').tap do |recipe|
    recipe.cuisine = Cuisine.find_by_name!('Japanese')
    recipe.user = james
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.save!
  end

  Recipe.find_or_initialize_by(name: 'Sourdough').tap do |recipe|
    recipe.user = holly
    recipe.length =  Recipe::LENGTHS.sample
    recipe.servings = [2,4,6].sample
    recipe.course = 'Main'
    recipe.image.attach(io: File.open(Rails.root.join('lib', 'assets', 'seed_images', 'sourdough.jpeg')), filename: 'image.jpeg')
    recipe.save!
  end

  Recipe.reindex
end
