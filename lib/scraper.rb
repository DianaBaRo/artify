require 'pry'
require 'open-uri'
require 'nokogiri'

  link = 'http://www.artlyst.com/whats-on/'
  html = open(link)
  index = Nokogiri::HTML(html)

  name = index.css("h4.event-name a").first.text
  venue = index.css()
  location = ikndex.css()

  binding.pry

class Scraper

  def self.scrape_index_page(index_url)
    
  end

  def self.scrape_profile_page(profile_url)
    
  end
end