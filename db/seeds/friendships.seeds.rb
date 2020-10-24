after :cuisines, :users do

  james = User.find_by_username!('James')
  holly = User.find_by_username!('Holly')
  tom = User.find_by_username!('Tom')
  beth = User.find_by_username!('Beth')

  friendship = Friendship.find_or_initialize_by(
    user: james,
    friend: beth
  )
  friendship.save!

  friendship = Friendship.find_or_initialize_by(
    user: james,
    friend: holly
  )
  friendship.accept!

  friendship = Friendship.find_or_initialize_by(
    user: holly,
    friend: tom
  )
  friendship.accept!

  friendship = Friendship.find_or_initialize_by(
    user: tom,
    friend: beth
  )
  friendship.accept!
end
