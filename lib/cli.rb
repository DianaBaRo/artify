require_relative "../lib/exhibition.rb"
require_relative "../lib/scraper.rb"
require 'nokogiri'

class CommandLineInterface
  BASE_LINK = 'http://www.artlyst.com/whats-on/'

  def run
    make_exhibitions
    add_attributes_to_exhibitions
    display_exhibitions
  end

  def make_exhibitions
    exhibitions_array = Scraper.scrape_index_page(BASE_LINK)
    Exhibition.create_from_collection(exhibitions_array)
  end

  def add_attributes_to_exhibitions
    Exhibition.all.each do |exhibition|
      attributes = Scraper.scrape_exhibition_page(BASE_LINK + exhibition.exhibition_url)
      exhibition.add_exhibition_attributes(attributes)
    end
  end

  def display_exhibitions
    Exhibition.all.each do |exhibition|
      puts "#{exhibition.name.upcase}"
      puts "  venue: #{exhibition.venue}"
      puts "  starting_date: #{exhibition.starting_date}"
      puts "  closing_date: #{exhibition.closing_date}"
      puts "  exhibition_url: #{exhibition.exhibition_url}"
      puts "  description: #{exhibition.description}"
      puts "  times: #{exhibition.times}"
      puts "  cost: #{exhibition.cost}"
      puts "  address: #{exhibition.address}"
      puts "  contact: #{exhibition.contact}"
      puts "  extended_description: #{exhibition.extended_description}"
      puts "----------------------"
    end
  end
end