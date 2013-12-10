module MtgHand

  class Deck

    attr_accessor :decklist

    def initialize(deck)
      @decklist      = deck.decklist
      @cards_in_hand = 7
    end

    def hand
      @cards_in_hand ||= 7

      puts "====================="
      puts "    STARTING HAND    "
      puts "====================="

      hand = decklist.sample(@cards_in_hand)
      hand.each do |card|
        puts card.cmc + " | " + card.mana_symbols + " | " + card.name + " | " + card.type
      end

      puts "====================="
      hand_analysis(hand)
      puts "====================="
    end

    def hand_analysis(hand)
      lands = 0

      hand.each do |card|
        card.type == "land" ? lands += 1 : nil
      end

      if lands <= 1
        puts lands.to_s + " land in your starting hand."
      else
        puts lands.to_s + " lands in your starting hand."
      end
    end

    def mulligan
      if @cards_in_hand <= 1
        puts "You can't mulligan anymore. You would have no cards in hand !"
      else
        @cards_in_hand -= 1
        hand
      end
    end

  end

  class Card
    attr_accessor :cmc, :mana_symbols, :name, :type
  end

  class Csv

    attr_accessor :lines, :path, :decklist

    def initialize(path)
      if path.include?(".csv")
        @path = path
      else
        @path = ENV["HOME"] + "/decks/" + path + ".csv"
      end
    end

    def self.read(path)
      instance = new(path)
      instance.lines = instance.read

      # Mapping of the CSV file's headers to its values
      to_convert = instance.lines
      headers    = to_convert.shift
      to_convert.map! do |ary|
        hsh = Hash.new
        ary.each_with_index{ |val,index| hsh[headers[index]] = val }
        hsh
      end

      # Creation of Card items based on previous mapping
      instance.decklist = []
      to_convert.each do |card|
        card["Quantity"].to_i.times {
          new_card = Card.new
          new_card.cmc  = card["CMC"]
          new_card.mana_symbols = card["Mana symbols"].to_s
          new_card.name = card["name"]
          new_card.type = card["type"]
          instance.decklist << new_card
        }
      end
      instance
    end

    def read
      File.readlines(path, "\r").map do |line|
        line.gsub(/\r/,"").split(";")
      end
    end

    def save
      @destination_folder = ENV["HOME"] + "/decks/"
      @destination_file   = ENV["HOME"] + "/decks/" + File.basename(path)

      if path.include?(@destination_folder) || File.exists?(@destination_file)
        puts "Your deck is already saved in your computer deck folder."
      else
        file_copy
      end
    end

    def update
      file_copy
      puts "Your deck has been successfully updated."
    end

    private

    def file_copy
      Dir.mkdir(@destination_folder) unless Dir.exists?(@destination_folder)

      input  = File.open(path, 'r')
      output = File.open(@destination_file, 'w')
      IO.copy_stream(input, output)
      input.close()
      output.close()
    end
  end

end
