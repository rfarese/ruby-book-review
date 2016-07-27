require 'omniauth'

Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :each do
    ActionMailer::Base.deliveries.clear
  end

  config.before :each do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  # tried added this to help with the API controller testing...
  # config.include Devise::TestHelpers, type: :controller
  OmniAuth.config.test_mode = true
  config.include AuthenticationHelper
  config.include TwitterUserCreatorHelper
  config.include UserSignInHelper
  config.include WaitForAjax, type: :feature 
end
