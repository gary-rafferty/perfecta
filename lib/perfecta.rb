require "perfecta/version"
require "perfecta/api_resource"
require "perfecta/campaign_report"
require "perfecta/ad_report"
require "perfecta/conversion_report"
require "perfecta/site"
require "perfecta/campaign"
require "perfecta/ad"
require "perfecta/conversion"
require "perfecta/segment"
require "rest-client"
require "json"

module Perfecta
  class Client

    BASE_API_PATH = 'https://api.perfectaudience.com'

    ALLOWED_REPORT_PARAMS = [
      :interval,
      :start_date,
      :end_date,
      :site_id,
      :campaign_id
    ].freeze

    attr_accessor :email, :password, :token

    def initialize &block
      yield self if block_given?
      @token = exchange_credentials_for_token
    end

    def campaign_reports params = {}
      url = "#{BASE_API_PATH}/reports/campaign_report"

      params.keep_if {|p| ALLOWED_REPORT_PARAMS.include? p}

      params = {params: params}.merge! Authorization: @token

      resp =  JSON.parse(RestClient.get(url, params))

      build_collection_of 'CampaignReport', resp
    end

    def ad_reports params = {}
      url = "#{BASE_API_PATH}/reports/ad_report"

      params.keep_if {|p| ALLOWED_REPORT_PARAMS.include? p}

      params = {params: params}.merge! Authorization: @token

      resp =  JSON.parse(RestClient.get(url, params))

      build_collection_of 'AdReport', resp
    end

    def conversion_reports params = {}
      url = "#{BASE_API_PATH}/reports/conversion_report"

      params.keep_if {|p| ALLOWED_REPORT_PARAMS.include? p}

      params = {params: params}.merge! Authorization: @token

      resp =  JSON.parse(RestClient.get(url, params))

      build_collection_of 'ConversionReport', resp
    end

    def sites
      url = "#{BASE_API_PATH}/sites"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      retval = []

      resp['sites'].each {|s| retval << Site.new(s)}

      retval
    end

    def site id
      url = "#{BASE_API_PATH}/sites/#{id}"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      Site.new resp['site']
    end

    def campaigns
      url = "#{BASE_API_PATH}/campaigns"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      retval = []

      resp['campaigns'].each {|s| retval << Campaign.new(s)}

      retval
    end

    def campaign id
       url = "#{BASE_API_PATH}/campaigns/#{id}"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      Campaign.new resp['campaign']
    end

    def ads
      url = "#{BASE_API_PATH}/ads"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      retval = []

      resp['ads'].each {|s| retval << Ad.new(s)}

      retval
    end

    def ad id
       url = "#{BASE_API_PATH}/ads/#{id}"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      Ad.new resp['ad']
    end

    def conversions
      url = "#{BASE_API_PATH}/conversions"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      retval = []

      resp['conversions'].each {|s| retval << Conversion.new(s)}

      retval
    end

    def conversion id
       url = "#{BASE_API_PATH}/conversions/#{id}"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      Conversion.new resp['conversion']
    end

    def segments
      url = "#{BASE_API_PATH}/segments"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      retval = []

      resp['segments'].each {|s| retval << Segment.new(s)}

      retval
    end

    def segment id
       url = "#{BASE_API_PATH}/segments/#{id}"

      resp = JSON.parse(RestClient.get(url, Authorization: @token))

      Segment.new resp['segment']
    end

    private

    def exchange_credentials_for_token
      authenticate
    end

    def authenticate
      url = "#{BASE_API_PATH}/auth"
      data = {email: @email, password: @password}

      resp = RestClient.post(url, data)

      json = JSON.parse resp

      if json['status'] == 200
        json['token']
      end
    end

    def build_collection_of klass, data
      retval = []

      raise BadResponse unless data['status'] == 200

      data['report'].each do |d|
        obj = Perfecta.const_get(klass.to_sym).new d
        retval << obj
      end

      retval
    end
  end

  class BadResponse < Exception; end
end
