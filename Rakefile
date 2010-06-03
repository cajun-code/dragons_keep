# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'bundler'


spec = Gem::Specification.new do |s|
  s.name = 'dragons_keep'
  s.version = '1.0.0'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'Your summary here'
  s.description = s.summary
  s.author = 'Allan Davis'
  s.email = 'javaalley@gmail.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec,db}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
  s.add_bundler_dependencies
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "dragons_keep Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

#desc "Migrate the database through migrations scripts"
#task :migrate => :enviroment do
#  ActiveRecord::Migrator.migrate('db/migrations', ENV["VERSION"]? ENV["VERSION"].to_i : nil)
#end
#
#task :enviroment do
#  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml')))
#  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
#end