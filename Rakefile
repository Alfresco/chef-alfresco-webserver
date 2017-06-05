# !/usr/bin/env rake

require 'yamllint/rake_task'

KITCHEN_DOCKER_FILENAME = '.kitchen.docker.yml'.freeze
KITCHEN_VAGRANT_FILENAME = '.kitchen.yml'.freeze
KITCHEN_DOCKER_DIFF_FILENAME = '.kitchen-diff.docker.yml'.freeze

desc 'Runs yamllint checks'
task :yamllint do
  YamlLint::RakeTask.new do |t|
    t.paths = %w( \.*\.y*ml )
  end
end

desc 'Runs cookstyle tests'
task :cookstyle do
  sh 'chef exec bundle exec cookstyle'
end

desc 'Runs foodcritic test'
task :foodcritic do
  sh 'chef exec bundle exec foodcritic -f any .'
end

desc 'Runs ChefSpec tests'
task :chefspec do
  sh 'chef exec bundle exec rspec'
end

desc 'Run Test Kitchen integration tests'
namespace :integration do
  # Gets a collection of instances.
  #
  # @param regexp [String] regular expression to match against instance names.
  # @param config [Hash] configuration values for the `Kitchen::Config` class.
  # @return [Collection<Instance>] all instances.
  def kitchen_instances(regexp, config)
    instances = Kitchen::Config.new(config).instances
    return instances if regexp.nil? || regexp == 'all'
    instances.get_all(Regexp.new(regexp))
  end

  # Runs a test kitchen action against some instances.
  #
  # @param action [String] kitchen action to run (defaults to `'test'`).
  # @param regexp [String] regular expression to match against instance names.
  # @param loader_config [Hash] loader configuration options.
  # @return void
  def run_kitchen(action, regexp, loader_config = {})
    action = 'test' if action.nil?
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    config = { loader: Kitchen::Loader::YAML.new(loader_config) }
    kitchen_instances(regexp, config).each { |i| i.send(action) }
  end

  desc 'Run integration tests with kitchen-vagrant'
  task :vagrant, [:regexp, :action] do |_t, args|
    run_kitchen(args.action, args.regexp, local_config: '.kitchen.yml')
  end

  desc 'Run integration tests with kitchen-docker'
  task :docker, [:regexp, :action] do |_t, args|
    require 'yaml'
    kvf = YAML.load_file(File.join(__dir__, KITCHEN_VAGRANT_FILENAME))
    kdf = YAML.load_file(File.join(__dir__, KITCHEN_DOCKER_DIFF_FILENAME))
    File.write(KITCHEN_DOCKER_FILENAME, kvf.merge(kdf).to_yaml)
    run_kitchen(args.action, args.regexp, local_config: KITCHEN_DOCKER_FILENAME)
  end
end

task default: [:yamllint, :foodcritic, :cookstyle, :chefspec]
