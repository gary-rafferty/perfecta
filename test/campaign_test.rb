require './test/test_helper.rb'

class CampaignTest < MiniTest::Unit::TestCase

  describe 'Campaign' do

    before do
      @attrs = {:name => 'Campaign 1'}
      @report = Perfecta::Campaign.new @attrs
    end

    it 'should be created from a hash' do
      @report.must_be_instance_of Perfecta::Campaign
    end

    it 'should set the values for each property' do
      @report.name.must_equal 'Campaign 1'
    end
  end
end
