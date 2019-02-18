require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
=begin
    html = open(index_url)
    index = Nokogiri::HTML(html)

    exhibitions = []

    individual_exhibition = index.css("div.tile-item.normal.Exhibition.recommended.editors_choice")

    individual_exhibition.each do |exhibition|
      exhibition_data = {}
      exhibition_data[:name] = exhibition.css("h4.event-name a").first.text
      exhibition_data[:venue] = exhibition.css("h5.tile-item--info---venue.venue").first.text
      exhibition_data[:starting_date] = exhibition.css("span.open-date").first.text
      exhibition_data[:closing_date] = exhibition.css("span.close-date").first.text
      exhibition_data[:description] = exhibition.css(".tile-item--info p:nth-of-type(2)").first.text

      exhibitions << exhibition_data
    end

    exhibitions
=end
  end

  def self.scrape_profile_page(profile_url)
    
  end
end

link = 'http://www.artlyst.com/whats-on/'
  html = open(link)
  index = Nokogiri::HTML(html)

  exhibition = index.css("div.tile-item.normal.Exhibition.recommended.editors_choice")
  name = exhibition.css("h4.event-name a").first.text
  venue = index.css("h5.tile-item--info---venue.venue").first.text
  starting_date = index.css("span.open-date").first.text
  closing_date = index.css("span.close-date").first.text
  description = index.css(".tile-item--info p:nth-of-type(2)").first.text
  binding.pry