class CommandLineInterface
  BASE_LINK = 'http://www.artlyst.com/whats-on/'

  def run
    
    input = ""
    puts "Hi and welcome to Artify!"
    until input == "exit"
      puts "To see all of the exhibitions listed in Artlyst at the moment, enter 'exhibitions'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.chomp.downcase
      
      if input == "exhibitions"
        make_exhibitions
        display_exhibitions
        puts "Enter the number of the exhibition which you would like to know more"
        
        input = ""
        input = gets.chomp.to_i 

        if input >= 1 && input < Exhibition.all.length
          Exhibition.all.each_with_index do |exhibition, index|
            if index + 1 == input
              attributes = Scraper.scrape_exhibition_page(exhibition.exhibition_url)
              exhibition.add_exhibition_attributes(attributes)
              display_exhibition(exhibition)
            end
          end
        end
      end
    end
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
    Exhibition.all.each_with_index do |exhibition, index|
      puts "#{index + 1}. #{exhibition.name.upcase} - #{exhibition.venue}"
      puts "  Starting date: #{exhibition.starting_date} - Closing date: #{exhibition.closing_date}"
    end
  end

  def display_exhibition(exhibition)
    puts "  Times: #{exhibition.times}"
    puts "  Cost: #{exhibition.cost}"
    puts "  Address: #{exhibition.address}"
    puts "  Contact: #{exhibition.contact}"
    puts "  Extended description: #{exhibition.extended_description}"
  end

end