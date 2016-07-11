if Rails.env.development?
  UserSeeder.seed!
  # add books
  BookSeeder.seed!
  # add reviews
  # add ranks
  # add votes
end
