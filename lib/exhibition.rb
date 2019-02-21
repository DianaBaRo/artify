class Exhibition

  attr_accessor :name, :venue, :starting_date, :closing_date, :exhibition_url, :times, :cost, :address, :contact

  @@all = []

  def initialize(exhibition_hash)
    exhibition_hash.each {|k,v| self.send(("#{k}="),v)}
    @@all << self
  end

  def self.create_from_collection(exhibitions_array) #Este array es el resultado de scrape_index_page
    exhibitions_array.each {|exhibition_hash| Exhibition.new(exhibition_hash)}
  end 

  def add_exhibition_attributes(attributes_hash)
    attributes_hash.each{|k,v| self.send(("#{k}="),v)}
    self
  end 

  def self.all
    @@all
  end

end
