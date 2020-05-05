namespace :test do
  desc 'Runs all tests and creates coverage'
  task :coverage do
    require 'simplecov'
    SimpleCov.start 'rails' # feel free to pass block
    ENV['COVERAGE'] = 'true'
    Rake::Task["test"].execute
  end
end
