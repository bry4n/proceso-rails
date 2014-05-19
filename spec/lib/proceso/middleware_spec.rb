require 'spec_helper'

describe Proceso::Middleware do


  let(:middleware) { Proceso::Middleware.new(Rails.application) }
  let(:env) do
    {
      'rack.input'    => StringIO.new,
      'PATH_INFO'     => '/',
      'REQUEST_METHOD' => 'GET'
    }
  end

  it "should have app" do
    middleware.app.should == Rails.application
  end

  it "should call" do
    Proceso::Middleware.start_instrument!
    middleware.call(env)
    logger = Rails.logger
    output = logger.outputs.grep(/[PROCESO]/).last
    output.include?("[PROCESO]").should be_true
  end


end
