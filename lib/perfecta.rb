require "perfecta/version"

module Perfecta
  class Client

    BASE_API_PATH = 'https://api.perfectaudience.com/'

    attr_accessor :email, :password, :token

    def initialize &block
      yield self if block_given?
    end

  end
end
