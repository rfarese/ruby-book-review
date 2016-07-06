require 'rails_helper'

RSpec.describe Rank, type: :model do
  it { should have_valid(:book_id).when(1, 2, 3)}
  it { should_not have_valid(:book_id).when(nil) }

  it { should have_valid(:user_id).when(1, 2, 4, 6) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:rank).when(1, 2, 3, 4, 5) }
  it { should_not have_valid(:rank).when(nil, 0, 6, 10) }
end
