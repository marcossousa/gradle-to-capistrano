# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "gradle-to-capistrano"
  gem.homepage = "http://github.com/marcossousa/gradle-to-capistrano"
  gem.license = "MIT"
  gem.summary = %Q{Capistrano recipe to run gradle commands to generate deployable artifacts}
  gem.description = %Q{This extension should be used to run gradle commands on gradle based projects. The artifacts generated will be compreessed and copied to the server}
  gem.email = "falecomigo@marcossousa.com"
  gem.authors = ["Marcos Sousa"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gradle-to-capistrano #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
