$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'rubygems'
require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/setup'
require 'perfecta'

require 'coveralls'
Coveralls.wear!
