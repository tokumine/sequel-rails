require 'active_support/core_ext/hash/except'

require 'sequel/extensions/migration'

require 'sequel-rails/configuration'
require 'sequel-rails/runtime'
require 'sequel-rails/railties/benchmarking_mixin'

module Rails
  module Sequel

    # Get or setup a connection for a given environment
    def self.connection(environment)
      @@connections[environment] ||= setup(environment)
    end

    def self.setup(environment)
      puts "[sequel] Setting up the #{environment.inspect} environment:"

      @@connections ||= {}
      @@connections[environment] ||= ::Sequel.connect({:logger => configuration.logger}.merge(::Rails::Sequel.configuration.environment_for(environment.to_s)))
      @@connections[environment]
    end

  end
end
