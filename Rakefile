require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  hosts = [
    {
      :name     =>  'localhost',
      :backend  =>  'exec',
      :nginx_root_config_remote =>  '/Users/travis/nginx/nginx.conf',
      :nginx_extra_configs_remote_dir =>  '/Users/travis/nginx/conf.d',
      :nginx_config_owner  =>  'travis',
      :nginx_config_group  =>  'staff'
    },
    {
      :name     =>  'container',
      :backend  =>  'docker',
      :nginx_root_config_remote =>  '/etc/nginx/nginx.conf',
      :nginx_extra_configs_remote_dir =>  '/etc/nginx/conf.d',
      :nginx_config_owner  =>  'root',
      :nginx_config_group  =>  'root'
    }
  ]
  if ENV['SPEC_TARGET'] then
    target = hosts.select{|h|  h[:name] == ENV['SPEC_TARGET']}
    hosts = target unless target.empty?
  end

  task :all     => hosts.map{|h|  "spec:#{h[:name]}"}
  task :default => :all

  hosts.each do |host|
    desc "Run serverspec tests to #{host[:name]}(backend=#{host[:backend]})"
    RSpec::Core::RakeTask.new(host[:name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      ENV['SPEC_TARGET_BACKEND'] = host[:backend]
      ENV['NGINX_ROOT_CONFIG_REMOTE'] = host[:nginx_root_config_remote]
      ENV['NGINX_EXTRA_CONFIGS_REMOTE_DIR'] = host[:nginx_extra_configs_remote_dir]
      ENV['NGINX_CONFIG_OWNER'] = host[:nginx_config_owner]
      ENV['NGINX_CONFIG_GROUP'] = host[:nginx_config_group]
      t.pattern = "spec/nginx_spec.rb"
    end
  end
end
