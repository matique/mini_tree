if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
  end
end

require "combustion"
Combustion.path = "test/dummy"
Combustion.initialize! :active_record

require "rails/test_help"
require "capybara/rails"
require "capybara/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    private

    def an_item(kind, parent_id = 0)
      position = NameTree.count + 1
      # NameTree.create! id: position, kind:, legend: "legend_#{position}",
      NameTree.create! kind:, legend: "legend_#{position}",
        position:, parent_id:
    end

    def a_node = an_item "node"

    def a_leaf(parent = nil)
      parent_id = 0
      parent_id = parent.position if parent
      an_item "leaf", parent_id
    end
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  # # Reset sessions and driver between tests
  # teardown do
  #   Capybara.reset_sessions!
  #   Capybara.use_default_driver
  # end
end
