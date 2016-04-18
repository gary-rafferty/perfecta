require_relative 'test_helper'

class AdReportTest < MiniTest::Test

  describe 'AdReport' do

    before do
      @attrs = {ad_name: 'Ad 1', ad_id: 123}
      @report = Perfecta::AdReport.new @attrs
    end

    it 'should be created from a hash' do
      @report.must_be_instance_of Perfecta::AdReport
    end

    it 'should set the values for each property' do
      @report.ad_name.must_equal 'Ad 1'
      @report.ad_id.must_equal 123
    end
  end
end
