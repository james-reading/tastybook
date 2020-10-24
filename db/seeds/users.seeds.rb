user = User.find_or_initialize_by(username: 'James')
user.update!(
  email: 'james@test.com',
  password: 'passw0rd',
  password_confirmation: 'passw0rd'
)

user = User.find_or_initialize_by(username: 'Holly')
user.update!(
  email: 'holly@test.com',
  password: 'passw0rd',
  password_confirmation: 'passw0rd'
)

user = User.find_or_initialize_by(username: 'Tom')
user.update!(
  email: 'tom@test.com',
  password: 'passw0rd',
  password_confirmation: 'passw0rd'
)

user = User.find_or_initialize_by(username: 'Beth')
user.update!(
  email: 'beth@test.com',
  password: 'passw0rd',
  password_confirmation: 'passw0rd'
)
