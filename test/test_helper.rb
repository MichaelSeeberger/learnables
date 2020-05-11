# IMPORTANT remove Warning[:deprecated] = false line as soon as the following gems fixed using deprecated feature (ruby 2.7):
# * rolify
# * devise
# * sprockets
Warning[:deprecated] = false


ENV['RAILS_ENV'] ||= 'test'
ENV['COVERAGE'] ||= 'false'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors) if ENV['COVERAGE'] == 'false'

  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end
