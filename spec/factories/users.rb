FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name "John"
    last_name "Smith"
    role "member"
    password "password"
    password_confirmation "password"
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@example.com" }
    first_name "Admin John"
    last_name "Admin Smith"
    role "admin"
    password "password"
    password_confirmation "password"
  end
end
