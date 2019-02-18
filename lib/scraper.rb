require 'pry'
require 'open-uri'
require 'nokogiri'

  link = 'http://www.artlyst.com/whats-on/'
  html = open(link)
  index = Nokogiri::HTML(html)

  name = index.css("h4.event-name a").first.text
  venue = index.css("h5.tile-item--info---venue.venue").first.text
  starting_date = index.css("span.open-date").first.text
  closing_date = index.css("span.close-date").first.text
  description = index.css(".tile-item--info p:nth-of-type(2)").first.text
  binding.pry

class Scraper

  def self.scrape_index_page(index_url)
    
  end

  def self.scrape_profile_page(profile_url)
    
  end
end