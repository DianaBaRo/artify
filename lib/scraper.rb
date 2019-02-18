require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

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
      exhibition_data[:individual_exhibition_url] = exhibition.css("h4.event-name a").attribute("href").value
      #exhibition_data[:description] = exhibition.css(".tile-item--info p:nth-of-type(2)").first.text

      exhibitions << exhibition_data
    end

    exhibitions

  end

  def self.scrape_individual_exhibition_page(individual_exhibition_url)
    html = open(profile_url)
    individual_exhibition = Nokogiri::HTML(html)

    exhibition = {}

    exhibition[:title] = individual_exhibition.css("h1.entry-title")
    exhibition[:times] = individual_exhibition.css("")
    exhibition[:cost] = individual_exhibition.css("")
    exhibition[:venue] = individual_exhibition.css("")
    exhibition[:address] = individual_exhibition.css("")
    exhibition[:contact] = individual_exhibition.css("")
    exhibition[:extended_description] = individual_exhibition.css("")

    exhibition

  end
end

=begin

link = 'http://www.artlyst.com/whats-on/'
  html = open(link)
  index = Nokogiri::HTML(html)

  exhibition = index.css("div.tile-item.normal.Exhibition.recommended.editors_choice")
  name = exhibition.css("h4.event-name a").first.text
  venue = index.css("h5.tile-item--info---venue.venue").first.text
  starting_date = index.css("span.open-date").first.text
  closing_date = index.css("span.close-date").first.text
  description = index.css(".tile-item--info p:nth-of-type(2)").first.text
  url = exhibition.css("h4.event-name a").attribute("href").value
  binding.pry

=end

  link = 'https://www.artlyst.com/whats-on-archive/young-gods/'
  html = open(link)
  individual_exhibition = Nokogiri::HTML(html)

  name = individual_exhibition.css("h1.entry-title").text
  times = individual_exhibition.css("")
  binding.pry
=begin
  cost = individual_exhibition.css("")
  address = individual_exhibition.css("")
  contact = individual_exhibition.css("")
  extended_description = individual_exhibition.css("")
=end
 