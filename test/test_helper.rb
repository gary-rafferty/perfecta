$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'minitest/spec'
require 'minitest/autorun'
require 'mocha/setup'
require 'perfecta'

require 'coveralls'
Coveralls.wear!
