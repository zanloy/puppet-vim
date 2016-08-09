source 'https://rubygems.org'
if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if hieraversion = ENV['HIERA_GEM_VERSION']
  gem 'hiera', hieraversion, :require => false
else
  gem 'hiera', :require => false
end

group :development, :test do
  gem 'puppet-blacksmith'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'
  gem 'rake', '>=0.9.2.2'
  gem 'rspec', '3.5.0'
  gem 'rspec-core', '3.5.2'
  gem 'rspec-puppet', '2.4.0'
  gem 'listen', '3.0.8'
  gem 'json', '1.8.3'
  gem 'json_pure', '1.8.3'
  gem 'guard'
  gem 'guard-rake'
  gem 'guard-rspec'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'growl',      :require => false
  gem 'libnotify',  :require => false
end
