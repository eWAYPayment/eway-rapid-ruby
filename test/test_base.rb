require 'simplecov'
SimpleCov.start

require 'test/unit'
require_relative '../lib/eway_rapid'
require_relative 'input_model_factory'
require_relative 'eway_rapid/object/create/object_creator'
require_relative 'eway_rapid/integration/integration_test'

class TestBase < Test::Unit::TestCase
end

