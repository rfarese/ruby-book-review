if Rails.env.development?
  UserSeeder.seed!
  BookSeeder.seed!
  ReviewSeeder.seed!
  # add ranks
  # add votes
end
