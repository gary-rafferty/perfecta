require_relative 'test_helper'

class SiteTest < MiniTest::Test

  describe 'Site' do

    before do
      @attrs = {name: 'Site 1'}
      @report = Perfecta::Site.new @attrs
    end

    it 'should be created from a hash' do
      @report.must_be_instance_of Perfecta::Site
    end

    it 'should set the values for each property' do
      @report.name.must_equal 'Site 1'
    end
  end
end
