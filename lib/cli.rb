class CommandLineInterface

  BASE_LINK = "http://www.artlyst.com/whats-on/"

  def run
    
    input = ""

    puts "Welcome to Artify!".colorize(:blue)

    until input == "exit"

      puts "To see all of the exhibitions listed in Artlyst at the moment, enter 'exhibitions'.".colorize(:blue)
      puts "To get more information about an exhibition, enter 'info'.".colorize(:blue)
      puts "To quit, type 'exit'.".colorize(:blue)
      puts "What would you like to do?".colorize(:blue)

      input = gets.chomp.downcase
      
      case input
      when "exhibitions"
        make_exhibitions
        display_exhibitions
      when "info"
        more_info
      end
    end
  end

  def make_exhibitions
    exhibitions_array = Scraper.scrape_index_page(BASE_LINK)
    Exhibition.create_from_collection(exhibitions_array)
  end

  def add_attributes
    attributes = Scraper.scrape_exhibition_page(exhibition.exhibition_url)
    exhibition.add_exhibition_attributes(attributes)
  end

  def display_exhibitions
    Exhibition.all.each_with_index do |exhibition, index|
      puts "#{index + 1}. #{exhibition.name.upcase} - #{exhibition.venue}".colorize(:blue)
      puts "    Starting date: #{exhibition.starting_date} - Closing date: #{exhibition.closing_date}"
      puts ""
    end
  end

  def display_exhibition(exhibition)
    puts "More information regarding " + "#{exhibition.name.upcase}".colorize(:blue) + " exhibition:"
    puts "  Times: ".colorize(:blue) + "#{exhibition.times}"
    puts "  Cost: ".colorize(:blue) + "#{exhibition.cost}"
    puts "  Address: ".colorize(:blue) + "#{exhibition.address}"
    puts "  Contact: ".colorize(:blue) + "#{exhibition.contact[3..-1]}"
  end

  def more_info
    puts "Enter the number of the exhibition which you would like to know more".colorize(:blue)
    input = ""
    input = gets.chomp.to_i
    make_exhibitions
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