FactoryGirl.define do
  factory :rank do
    rank [1, 2, 3, 4,5].sample

    association :book, factory: :book
    association :user, factory: :user
  end
end
