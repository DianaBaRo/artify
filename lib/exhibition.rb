class Exhibition

  attr_accessor :name, :venue, :starting_date, :closing_date, :exhibition_url, :times, :cost, :address, :contact

  @@all = []

  def initialize(exhibition_hash)
    exhibition_hash.each {|k,v| self.send(("#{k}="),v)}
    @@all << self
  end

  def self.create_from_collection(exhibitions_array)
    exhibitions_array.each {|exhibition_hash| Exhibition.new(exhibition_hash)}
  end 

  def self.all
    @@all
  end

end
