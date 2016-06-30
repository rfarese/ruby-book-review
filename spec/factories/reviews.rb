FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "Review Title #{n}" }
    sequence(:description) { |n| "Review Description #{n}" }

    association :user, factory: :user
    association :book, factory: :book
  end
end
