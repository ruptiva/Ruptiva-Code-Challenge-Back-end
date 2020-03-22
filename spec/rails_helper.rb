# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Rails.application.routes.url_helpers
  config.include AbstractController::Translation
  config.include FactoryBot::Syntax::Methods

  Shoulda::Matchers.configure do |shoulda_matchers|
    shoulda_matchers.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!
  config.include Requests::JsonHelpers, type: :request
end
