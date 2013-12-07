require 'csv'

module MtgHand

  class Deck

    def initialize
      @path = "/decks"
    end

    def self.read(file)
      @deck = CSV.read(file, headers: true, col_sep: ";")
      @starting_hand = []
      @deck.each do |card|
        card["Quantity"].to_i.times { puts card["CMC"] + " | " + card["Mana symbols"].to_s + " | " +  card["name"] + " | " +  card["type"] }
        card["Quantity"].to_i.times { @starting_hand << card["CMC"] + " | " + card["Mana symbols"].to_s + " | " +  card["name"] + " | " +  card["type"] }
      end

    end

    def self.hand
      puts "====================="
      puts "    STARTING HAND    "
      puts "====================="
      puts @starting_hand.sample(7)
    end

    def self.save(file)
      deckfile = File.new(file, "r")
      deckfile.path = @path
      deckfile.save!
    end

  end

end
