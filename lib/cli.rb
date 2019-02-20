#require_relative "../config/environment.rb"
#require_relative "../lib/exhibition.rb"
#require_relative "../lib/scraper.rb"
#require 'nokogiri'
#require 'open-uri'

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
      attributes = Scraper.scrape_exhibition_page(exhibition.exhibition_url)
      exhibition.add_exhibition_attributes(attributes)
    end
  end

  def display_exhibitions
    Exhibition.all.each do |exhibition|
      puts "#{exhibition.name.upcase}"
      puts "  Venue: #{exhibition.venue}"
      puts "  Starting date: #{exhibition.starting_date}"
      puts "  Closing date: #{exhibition.closing_date}"
      puts "  Times: #{exhibition.times}"
      puts "  Cost: #{exhibition.cost}"
      puts "  Address: #{exhibition.address}"
      puts "  Contact: #{exhibition.contact}"
      puts "  Extended description: #{exhibition.extended_description}"
      puts "----------------------"
    end
  end
end