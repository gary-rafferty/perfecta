require 'test_helper'

class CampaignReportTest < MiniTest::Unit::TestCase

  describe 'CampaignReport' do

    before do
      @attrs = {:name => 'Report 1', :campaign_id => 123}
      @report = Perfecta::CampaignReport.new @attrs
    end

    it 'should be created from a hash' do
      @report.must_be_instance_of Perfecta::CampaignReport
    end

    it 'should set the values for each property' do
      @report.name.must_equal 'Report 1'
      @report.campaign_id.must_equal 123
    end
  end
end
