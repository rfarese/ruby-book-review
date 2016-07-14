FactoryGirl.define do
  factory :rank do
    score [1, 2, 4, 5].sample

    association :book, factory: :book
    association :user, factory: :user
  end
end
