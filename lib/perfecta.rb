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
require "active_support/inflector"

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
      url, params = build_report_url_and_params_for('campaign', params)

      resp =  JSON.parse(RestClient.get(url, params))

      build_collection_of 'CampaignReport', resp
    end

    def ad_reports params = {}
      url, params = build_report_url_and_params_for('ad', params)

      resp =  JSON.parse(RestClient.get(url, params))

      build_collection_of 'AdReport', resp
    end

    def conversion_reports params = {}
      url, params = build_report_url_and_params_for('conversion', params)

      resp =  JSON.parse(RestClient.get(url, params))

      build_collection_of 'ConversionReport', resp
    end

    def sites
      get_many 'sites'
    end

    def site id
      get_one 'site', id
    end

    def campaigns
      get_many 'campaigns'
    end

    def campaign id
      get_one 'campaign', id
    end

    def ads
      get_many 'ads'
    end

    def ad id
      get_one 'ad', id
    end

    def conversions
      get_many 'conversions'
    end

    def conversion id
      get_one 'conversion', id
    end

    def segments
      get_many 'segments'
    end

    def segment id
      get_one 'segment', id
    end

    private

    def exchange_credentials_for_token
      authenticate
    end

    def authenticate
      url = "#{BASE_API_PATH}/auth"
      data = {:email => @email, :password => @password}

      resp = RestClient.post(url, data)

      json = JSON.parse resp

      if json['status'] == 200
        json['token']
      end
    end

    def build_collection_of klass, data
      raise BadResponse unless data['status'] == 200

      data['report'].map do |d|
        Perfecta.const_get(klass.to_sym).new d
      end
    end

    def get_one type, id
      url = "#{BASE_API_PATH}/#{type.pluralize}/#{id}"

      resp = JSON.parse(RestClient.get(url, "Authorization".to_sym => @token))

      klass_name = type.capitalize
      klass = Perfecta.const_get(klass_name.to_sym)

      obj = klass.new resp[type]

      obj
    end

    def get_many type
      url = "#{BASE_API_PATH}/#{type}"

      resp = JSON.parse(RestClient.get(url, "Authorization".to_sym => @token))

      klass_name = type.capitalize.singularize
      klass = Perfecta.const_get(klass_name.to_sym)

      resp[type].map do |obj|
        klass.new(obj)
      end
    end

    def build_report_url_and_params_for type, params
      url = "#{BASE_API_PATH}/reports/#{type}_report"

      params.delete_if {|p| !ALLOWED_REPORT_PARAMS.include? p}

      params = {:params => params}.merge! "Authorization".to_sym => @token

      [url, params]
    end
  end

  class BadResponse < Exception; end
end
