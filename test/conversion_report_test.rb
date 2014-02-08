require './test/test_helper.rb'

class ConversionReportTest < Minitest::Test

  describe 'ConversionReport' do

    before do
      @attrs = {:conversion_name => 'Conversion 1', :conversion_id => 123}
      @report = Perfecta::ConversionReport.new @attrs
    end

    it 'should be created from a hash' do
      @report.must_be_instance_of Perfecta::ConversionReport
    end

    it 'should set the values for each property' do
      @report.conversion_name.must_equal 'Conversion 1'
      @report.conversion_id.must_equal 123
    end
  end
end
