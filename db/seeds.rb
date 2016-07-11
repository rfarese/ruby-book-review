if Rails.env.development?
  UserSeeder.seed!
  # add books
  BookSeeder.seed!
  # add reviews
  ReviewSeeder.seed!
  # add ranks
  # add votes
end
