require 'rails_helper'

RSpec.feature "User creates a review", type: :feature do
  def create_user
    FactoryGirl.create(:user)
  end

  def create_book
    FactoryGirl.create(:book)
  end

  def sign_in_user(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

#   Acceptance Criteria:
#     * There is form to add a review on the book details / book show page
#     * An unauthenticated user will receive an error message if they attempt to create a review
#     * The reviews will populate under the book details
#     * The reviews will have a title, description, and show the users first name that created the review 

  scenario ""
end
