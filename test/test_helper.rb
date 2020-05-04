# IMPORTANT remove this line as soon as rails fixed using deprecated methods (6.0.3?)
Warning[:deprecated] = false


ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  #parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end
