require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest'
require 'minitest/autorun'
require 'minitest/ci'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  if ENV['CIRCLE_TEST_REPORTS']
    Minitest::Ci.report_dir = "#{ENV['CIRCLE_TEST_REPORTS']}/reports"
  end
  # Add more helper methods to be used by all tests here...
end
