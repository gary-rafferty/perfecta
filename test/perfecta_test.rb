require_relative 'test_helper'

class PerfectaTest < MiniTest::Test

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

    it "can retrieve and return campaign_reports" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'report' => [{
          'campaign_id' => '5074bc89d7a67f0002000026',
          'campaign_name' => 'My campaign',
          'impressions' => 25000,
          'clicks' => 750,
          'costs' => 25.2,
          'click_conversions' => 10,
          'view_conversions' => 20,
          'conversions' => 30,
          'cpm' => 1.008,
          'ctr' =>  0.03,
          'cpc' => 0.0336,
          'conversion_rate' => 0.04
        }]
      })

      campaign_report = @client.campaign_reports.first
      campaign_report.must_be_instance_of Perfecta::CampaignReport
      campaign_report.impressions.must_equal 25000
    end

    it "can retrieve and return ad_reports" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'report' => [{
          'ad_id' => '5074bc89d7a67f0002000026',
          'ad_name' => 'My ad',
          'impressions' => 25000,
          'clicks' => 750,
          'costs' => 25.2,
          'click_conversions' => 10,
          'view_conversions' => 20,
          'conversions' => 30,
          'cpm' => 1.008,
          'ctr' =>  0.03,
          'cpc' => 0.0336,
          'conversion_rate' => 0.04
        }]
      })

      ad_report = @client.ad_reports.first
      ad_report.must_be_instance_of Perfecta::AdReport
      ad_report.impressions.must_equal 25000
    end

    it "can retrieve and return conversion_reports" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'report' => [{
          'conversion_id' => '5074bc89d7a67f0002000026',
          'conversion_name' => 'Sale',
          'click_conversions' => 10,
          'view_conversions' => 20,
          'conversions' => 30,
        }]
      })

      conversion_report = @client.conversion_reports.first
      conversion_report.must_be_instance_of Perfecta::ConversionReport
      conversion_report.conversions.must_equal 30
    end

    it "can retrieve and return site objects" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'sites' => [{
          '_id' => '5074bc89d7a67f0002000026',
          'name' => 'My Site',
          'url' => 'https://www.perfectaudience.com',
          'created_at' => '2013-01-11T16:38:32+00:00',
          'view_conversion_window' => 30,
          'click_conversion_window' => 30,
          'domain_blacklist' => 'http://blacklist.com,http://donotserve.com'
        }]
      })

      site_obj = @client.sites.first
      site_obj.must_be_instance_of Perfecta::Site
      site_obj.name.must_equal 'My Site'
    end

    it "can retrieve and return campaign objects" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'campaigns' => [{
          '_id' => '5074bc89d7a67f0002000026',
          'site_id' => '4ff6ade4361ed500020111a5',
          'name' => 'My Campaign',
          'created_at' => '2013-01-11T16:38:32+00:00',
          'state' => 'active',
          'start_date' => '2012-12-18T00:00:00+00:00',
          'end_date' => '2013-03-18T00:00:00+00:00',
          'cpm_max_bid' => 0.5,
          'weekly_budget' => 500
        }]
      })

      campaign_obj = @client.campaigns.first
      campaign_obj.must_be_instance_of Perfecta::Campaign
      campaign_obj.weekly_budget.must_equal 500
    end

    it "can retrieve and return ad objects" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'ads' => [{
          '_id' => '5074bc89d7a67f0002000026',
          'site_id' => '4ff6ade4361ed500020111a5',
          'name' => 'My ad',
          'state' => 'active',
          'click_url' => 'https://www.perfectaudience.com',
          'created_at' => '2013-01-11T16:38:32+00:00',
          'dimensions' => '99x72',
          'type' => 'facebook',
          'facebook_title' => 'title',
          'facebook_body' => 'body'
        }]
      })

      ad_obj = @client.ads.first
      ad_obj.must_be_instance_of Perfecta::Ad
      ad_obj.type.must_equal 'facebook'
    end

    it "can retrieve and return segment objects" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'segments' => [{
          '_id' => '5074bc89d7a67f0002000026',
          'site_id' => '4ff6ade4361ed500020111a5',
          'name' => 'My Segment',
          'created_at' => '2013-01-11T16:38:32+00:00',
          'duration' => 45,
          'goal' => 'path',
          'target_text' => '/trial*'
        }]
      })

      segment_obj = @client.segments.first
      segment_obj.must_be_instance_of Perfecta::Segment
      segment_obj.duration.must_equal 45
    end

    it "can retrieve and return conversion objects" do
      @client.stubs(:make_request).returns({
        'status' => 200,
        'conversions' => [{
          '_id' => '5074bc89d7a67f0002000026',
          'site_id' => '4ff6ade4361ed500020111a5',
          'name' => 'Signup',
          'created_at' => '2013-01-11T16:38:32+00:00',
          'conversion_frequency' => 'every',
          'last_fired' => '2013-03-19T21:29:02+00:00',
          'goal' => 'path',
          'target_text' => '/orderSuccess'
        }]
      })

      conv_obj = @client.conversions.first
      conv_obj.must_be_instance_of Perfecta::Conversion
      conv_obj.goal.must_equal 'path'
    end
  end
end
