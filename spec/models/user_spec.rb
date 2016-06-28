require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when("Bobby", "Sarah" )}
  it { should_not have_valid(:first_name).when(nil, "") }

  it { should have_valid(:last_name).when("Farese", "Smith") }
  it { should_not have_valid(:last_name).when(nil, "") }

  it { should have_valid(:email).when("email@yahoo.com", "rfarese@gmail.com") }
  it { should_not have_valid(:email).when(nil, "", "userMan", "uManDude.com", "@com") }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
