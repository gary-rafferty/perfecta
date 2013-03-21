require "perfecta/version"

module Perfecta
  class Client

    attr_accessor :email, :password

    def initialize &block
      yield self if block_given?
    end

  end
end
