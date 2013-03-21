require_relative 'test_helper'

class PerfectaTest < MiniTest::Unit::TestCase

  describe 'Perfecta client' do
    it 'is initialized with an email and password' do
      client = Perfecta::Client.new do |c|
        c.email = 'email'
        c.password = 'password'
      end

      client.must_be_instance_of Perfecta::Client
    end
  end
end
