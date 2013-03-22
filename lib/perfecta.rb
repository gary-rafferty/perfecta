require "perfecta/version"
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

    private 

    def exchange_credentials_for_token
      authenticate
    end

    def authenticate
      url = "#{BASE_API_PATH}/auth"
      data = {email: @email, password: @password}

      resp = RestClient.post(url, data)

      json = JSON.parse resp

      if json[:status] == 200
        json[:token]
      end
    end
  end
end
