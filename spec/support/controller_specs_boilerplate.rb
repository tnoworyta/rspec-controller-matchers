require "action_view"
require "action_controller"
require "active_record"
require "rails"
require "rspec/rails"

module Test
  class TestApplication < ::Rails::Application
  end
  TestApplication.config.secret_key_base = "test"
end

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

load "spec/schema.rb"

RSpec.configure do |config|
  config.before(:each) do
    ActiveRecord::Base.connection.execute("DELETE FROM users;")
  end
end
