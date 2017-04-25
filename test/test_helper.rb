require 'simplecov'
require 'simplecov-console'

SimpleCov.start
SimpleCov.formatter = SimpleCov::Formatter::Console

require 'minitest/autorun'
require 'nokogiri'
require 'xml_jats_resolver'
