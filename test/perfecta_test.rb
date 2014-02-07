require 'test_helper'

class PerfectaTest < MiniTest::Unit::TestCase

  describe 'Perfecta client' do

    before do
      Perfecta::Client
        .any_instance
        .stubs(:exchange_credentials_for_token)
        .returns('token')

      @client = Perfecta::Client.new do |c|
        c.email = 'email@ddress'
        c.password = 'password'
      end
    end

    it 'is initialized with an email and password' do
      @client.must_be_instance_of Perfecta::Client
    end

    it "sets the email and password vars" do
      @client.email.must_equal 'email@ddress'
      @client.password.must_equal 'password'
    end

    it "should authenticate and set the token" do
      @client.token.wont_be_nil
      @client.token.must_equal 'token'
    end
  end
end
