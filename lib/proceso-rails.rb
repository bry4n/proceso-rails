require 'rails'
require 'proceso'
require 'proceso/middleware'

module Proceso
  class Railtie < Rails::Railtie

    config.proceso = ActiveSupport::OrderedOptions.new

    config.proceso.environments = ['development']
    config.proceso.exclusions   = [/\.(js|wot|jpg|jpeg|gif|png|css)$/]

    initializer 'proceso.initializer' do |app|
      if environment_enabled?
        app.middleware.insert 0, Proceso::Middleware, config: config.proceso
        Proceso::Middleware.start_instrument!
      end
    end

    def environments
      config.proceso.environments.uniq.map(&:to_s).compact
    end

    def environment_enabled?
      environments.include?(Rails.env.to_s)
    end

  end
end
