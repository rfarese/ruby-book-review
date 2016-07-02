FactoryGirl.define do
  factory :vote do
    up_vote true
    down_vote false

    association :user, factory: :user
    association :review, factory: :review
  end
end
