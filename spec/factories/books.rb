FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Book Title #{n}" }
    sequence(:author) { |n| "Book Author #{n}" }
    sequence(:description) { |n| "Great Book Description #{n}" }

    association :user, factory: :user
  end
end
