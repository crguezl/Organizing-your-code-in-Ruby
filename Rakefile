require 'rake/gempackagetask'

spec = Gem::Specification.load(Dir['*.gemspec'].first)
gem = Rake::GemPackageTask.new(spec)
gem.define

desc "Push gem to rubygems.org"
task :push => :gem do
  sh "gem push #{gem.package_dir}/#{gem.gem_file}"
end

require 'rake/testtask'

# rake test TEST=just_one_file.rb     # run just one test file.
# rake test TESTOPTS="-v"             # run in verbose mode
Rake::TestTask.new do |t|
  # t.libs: List of directories to be added to $LOAD_PATH. (default is ‘lib’)
  t.libs << "test" 
  t.pattern = 'test/tc*.rb' # or t.test_files = FileList['test/tc*.rb'] 
  t.warning = true
  t.verbose = true # verbose test output. (default is false)
end


task :clean => :clobber_package
require 'rake/clean'
CLEANLIST = [ 'pkg/' ]
CLEAN.include(CLEANLIST)


