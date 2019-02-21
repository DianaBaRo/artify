class Artify

  BASE_LINK = "http://www.artlyst.com/whats-on/"

  def run
    
    input = ""
    
    banner = "               _   _  __       
    /\\        | | (_)/ _|      
   /  \\   _ __| |_ _| |_ _   _ 
  / /\\ \\ | '__| __| |  _| | | |
 / ____ \\| |  | |_| | | | |_| |
/_/    \\_\\_|   \\__|_|_|  \\__, |
                          __/ |
                         |___/ ".colorize(:blue)

    print banner    
    
    2.times {puts}

    puts "Welcome to Artify!"

    until input == "exit"

      puts "To see all of the exhibitions listed in Artlyst at the moment, enter " + "'exhibitions'".colorize(:blue) + "."
      puts "To get more information about an exhibition, enter " + "'info'".colorize(:blue) + "."
      puts "To quit, type " + "'exit'".colorize(:blue) + "."
      puts "What would you like to do?"

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

  def display_exhibitions
    puts
    puts "List of exhibitions:"
    Exhibition.all.each_with_index do |exhibition, index|
      puts
      puts "#{index + 1}. #{exhibition.name.upcase} - #{exhibition.venue}".colorize(:blue)
      puts "    Starting date: #{exhibition.starting_date} - Closing date: #{exhibition.closing_date}"
      puts 
    end
  end

  def more_info
    puts "Enter the number of the exhibition which you would like to know more."
    input = ""
    input = gets.chomp.to_i
    make_exhibitions
    if input >= 1 && input < Exhibition.all.length
      Exhibition.all.each_with_index do |exhibition, index|
        if index + 1 == input
          attributes = Scraper.scrape_exhibition_page(exhibition.exhibition_url)
          exhibition.add_exhibition_attributes(attributes)
          
          puts
          puts "More information regarding " + "#{exhibition.name.upcase}".colorize(:blue) + " exhibition:"
          puts
          puts "  Times: ".colorize(:blue) + "#{exhibition.times}"
          puts "  Cost: ".colorize(:blue) + "#{exhibition.cost}"
          puts "  Address: ".colorize(:blue) + "#{exhibition.address}"
          puts "  Contact: ".colorize(:blue) + "#{exhibition.contact[3..-1]}"
          puts
        end
      end
    end
  end
  
end