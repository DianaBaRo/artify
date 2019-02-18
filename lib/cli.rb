class CommandLineInterface
  BASE_PATH = "./fixtures/student-site/"

  def run
    make_exhibitions
    add_attributes_to_exhibitions
    display_exhibitions
  end

  def make_exhibitions
    exhibitions_array = Scraper.scrape_index_page(BASE_PATH)
    Exhibition.create_from_collection(exhibitions_array)
  end

  def add_attributes_to_exhibitions
    Exhibition.all.each do |exhibition|
      attributes = Scraper.scrape_profile_page(BASE_PATH + exhibition.profile_url)
      exhibition.add_student_attributes(attributes)
    end
  end

  def display_exhibitions
    Exhibition.all.each do |exhibition|
      puts "#{exhibition.name.upcase}"
      puts "  venue: #{exhibition.venue}"
      puts "  duration: #{exhibition.duration}"
      puts "  times: #{exhibition.times}"
      puts "  cost: #{exhibition.cost}"
      puts "  address: #{exhibition.address}"
      puts "  contact: #{exhibition.contact}"
      puts "----------------------"
    end
  end
end