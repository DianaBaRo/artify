class CLI

  BASE_LINK = "http://www.artlyst.com/whats-on/"

  def call 
    menu
    goodbye
  end

  def menu
    make_exhibitions

    input = ""

    a = Artii::Base.new
    print a.asciify('artify').colorize(:blue)

    puts "\n\nWelcome to Artify!"

    until input == "exit"
      puts "\nTo see all of the exhibitions listed in Artlyst at the moment, enter " + "'exhibitions'".colorize(:blue) + "."
      puts "To get more information about an exhibition, enter " + "'info'".colorize(:blue) + "."
      puts "To quit, type " + "'exit'".colorize(:blue) + "."
      puts "What would you like to do?"

      input = gets.chomp.downcase

      case input
      when "exhibitions"
        display_exhibitions
      when "info"
        more_info
      else
        puts "\nNot sure what you mean." unless input == "exit"
      end

    end
  end

  def make_exhibitions
    if Exhibition.all.empty?
      exhibitions_array = Scraper.scrape_index_page(BASE_LINK)
      Exhibition.create_from_collection(exhibitions_array)
    end
  end

  def display_exhibitions
    puts "\nList of exhibitions:"

    Exhibition.all.each_with_index do |exhibition, index|
      puts "\n#{index + 1}. #{exhibition.name.upcase} - #{exhibition.venue}".colorize(:blue)
      puts "    Starting date: #{exhibition.starting_date} - Closing date: #{exhibition.closing_date}\n"
    end
  end

  def more_info
    puts "Enter the number of the exhibition which you would like to know more."

    input = ""
    input = gets.chomp.to_i
    
    if input >= 1 && input <= Exhibition.all.length
      Exhibition.all.each_with_index do |exhibition, index|
        if index + 1 == input
          attributes = Scraper.scrape_exhibition_page(exhibition.exhibition_url)
          exhibition.add_exhibition_attributes(attributes)
          puts "\nMore information regarding " + "#{exhibition.name.upcase}".colorize(:blue) + " exhibition:\n"
          puts "  Times: ".colorize(:blue) + "#{exhibition.times}"
          puts "  Cost: ".colorize(:blue) + "#{exhibition.cost}"
          puts "  Address: ".colorize(:blue) + "#{exhibition.address}"
          puts "  Contact: ".colorize(:blue) + "#{exhibition.contact[3..-1]}\n"
        end
      end
    else
      puts "Sorry, this number doesn't match with any of the exhibitions listed"
    end
  end

  def goodbye
    a = Artii::Base.new
    print a.asciify('Bye!').colorize(:blue)
    puts
    puts
  end
  
end