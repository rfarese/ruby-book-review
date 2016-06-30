require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_valid(:title).when("Some Review Title", "Review Title Stuff") }
  it { should_not have_valid(:title).when(nil, "") }

  it { should have_valid(:description).when("This is a description for a review for a book and it is a valid one believe it or not.") }
  it { should_not have_valid(:description).when(nil, "") }
end
