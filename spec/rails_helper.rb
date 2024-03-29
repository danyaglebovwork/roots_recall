require "spec_helper"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

module StoreApi
  module RSpec
    module RequestHelpers
      def default_headers
        {
          "ACCEPT" => "application/json",
          "CONTENT_TYPE" => "application/json"
        }
      end
    end
  end
end

module ActionDispatch
  class TestResponse
    def json
      JSON.parse(body, symbolize_names: true)
    end
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join("spec/fixtures")
  ]

  config.include StoreApi::RSpec::RequestHelpers, type: :request

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
