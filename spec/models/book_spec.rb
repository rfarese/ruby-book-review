require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_valid(:title).when("Some Book Title", "Book Title Stuff") }
  it { should_not have_valid(:title).when(nil, "") }

  it { should have_valid(:author).when("Mark Smith", "Bobby LastName")}
  it { should_not have_valid(:author).when(nil, "") }

  it { should have_valid(:description).when("This is a description and it is a really good one at that.") }
  it { should_not have_valid(:description).when(nil, "") }

  it { should have_valid(:book_cover_photo).when(nil, "", "http://www.someurl.com") }
end
