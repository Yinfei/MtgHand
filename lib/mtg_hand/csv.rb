module MtgHand

  class Csv

    attr_accessor :lines, :path, :decklist

    def initialize(path)
      @destination_folder = ENV["HOME"] + "/decks/"
      @destination_file   = ENV["HOME"] + "/decks/" + File.basename(path)
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
          new_card = Card.new(card)
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
