FactoryGirl.define do
  factory :book do
    title "First Book Title"
    author "First Bob Smith"
    description "This is a really good description for a really good book"

    association :user, factory: :user
  end
end
