require 'bundler/setup'
Bundler.require(:default, :development)

require 'open-uri'
require 'colorize'
require 'artii'

require_relative "../lib/artify.rb"
require_relative "../lib/exhibition.rb"
require_relative "../lib/scraper.rb"
