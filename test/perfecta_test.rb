require_relative 'test_helper'

class PerfectaTest < MiniTest::Unit::TestCase

  describe 'Perfecta client' do

    before do
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

  end
end
