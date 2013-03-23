require "perfecta/version"
require "perfecta/api_resource"
require "perfecta/campaign_report"
require "perfecta/ad_report"
require "rest-client"
require "json"

module Perfecta
  class Client

    BASE_API_PATH = 'https://api.perfectaudience.com'

    attr_accessor :email, :password, :token

    def initialize &block
      yield self if block_given?
      @token = exchange_credentials_for_token
    end

    def campaign_reports
      url = "#{BASE_API_PATH}/reports/campaign_report"
      resp =  JSON.parse(RestClient.get(url, {Authorization: @token}))

      retval = []
      resp['report'].each do |report_data|
        report = CampaignReport.new report_data
        retval << report
      end

      retval
    end

    def ad_reports
      url = "#{BASE_API_PATH}/reports/ad_report"
      resp =  JSON.parse(RestClient.get(url, {Authorization: @token}))

      retval = []
      resp['report'].each do |report_data|
        report = AdReport.new report_data
        retval << report
      end

      retval
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
  end
end
