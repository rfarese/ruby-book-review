class UserSeeder
  USERS = [
    {
      email: "user1@example.com",
      first_name: "John1",
      last_name: "Smith1",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "willmatt@example.com",
      first_name: "Willy",
      last_name: "Mattius",
      password: "willmatt",
      password_confirmation: "willmatt"
    },
    {
      email: "juju@example.com",
      first_name: "JuJu",
      last_name: "Bees",
      password: "jujubees",
      password_confirmation: "jujubees"
    },
    {
      email: "snikers@example.com",
      first_name: "Johnny",
      last_name: "Snickers",
      password: "caramelnutschocolate",
      password_confirmation: "caramelnutschocolate"
    },
    {
      email: "blogsrule@example.com",
      first_name: "WholeFoods",
      last_name: "Blogs",
      password: "healthysnacks",
      password_confirmation: "healthysnacks"
    },
    {
      email: "broccoli@example.com",
      first_name: "Ilike",
      last_name: "Broccoli",
      password: "bestveggyever",
      password_confirmation: "bestveggyever"
    },
    {
      email: "apple@example.com",
      first_name: "Apples",
      last_name: "Tastegood",
      password: "bestfruitever",
      password_confirmation: "bestfruitever"
    },
    {
      email: "coder@example.com",
      first_name: "Jeremy",
      last_name: "Codesmith",
      password: "rubyrulesall",
      password_confirmation: "rubyrulesall"
    }
  ]

  def self.seed!
    USERS.each do |user_params|
      email = user_params[:email]
      user = User.find_or_initialize_by(email: email)
      user.assign_attributes(user_params)
      user.save!
    end
  end
end
