$LOAD_PATH.unshift "lib"

require 'rails'
require 'action_controller/railtie'
require 'proceso-rails'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

class TestLogger

  attr_reader :outputs

  def initialize
    @outputs = []
  end
  
  def info(text)
    @outputs << text
  end
  alias :debug :info

end

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
  config.session_store :cookie_store, key: 'cookie_store_key'
  config.secret_token    = '6103e0a02bd376f18cd16ab84189925f'
  config.secret_key_base = '6103e0a02bd376f18cd16ab84189925f'

  config.logger = TestLogger.new
  Rails.logger  = config.logger
  
  routes.draw do
    root to: "test#index"
  end
end

class TestController < ActionController::Base
  def index
    render text: "Hello, world!"
  end
end

