require 'active_support/core_ext/hash/except'

require 'sequel/extensions/migration'

require 'sequel-rails/configuration'
require 'sequel-rails/runtime'
require 'sequel-rails/railties/benchmarking_mixin'

module Rails
  module Sequel

    def self.connection(environment = nil)
      environment ||= Rails.env
      @@connections[environment] ||= setup(environment)
    end

    def self.setup(environment = nil)
      environment ||= Rails.env
      puts "[sequel] Setting up the #{environment.inspect} environment:"

      @@connections ||= {}
      @@connections[environment] ||= ::Sequel.connect({:logger => configuration.logger}.merge(::Rails::Sequel.configuration.environment_for(environment.to_s)))
      @@connections[environment]
    end

  end
end
