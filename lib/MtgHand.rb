require 'csv'

module MtgHand

  class Deck

    def self.read(file)
      @deckfile = CSV.read(file, headers: true, col_sep: ";")
      @decklist = []
      @deckfile.each do |card|
        card["Quantity"].to_i.times { puts card["CMC"] + " | " + card["Mana symbols"].to_s + " | " +  card["name"] + " | " +  card["type"] }
        card["Quantity"].to_i.times {
          new_card = Card.new
          new_card.cmc = card["CMC"]
          new_card.mana_symbols = card["Mana symbols"].to_s
          new_card.name = card["name"]
          new_card.type = card["type"]
          @decklist << new_card
        }
      end

      # Reset cards in hand after previous mulligans
      @cards_in_hand = 7
    end

    def self.hand
      @cards_in_hand ||= 7

      puts "====================="
      puts "    STARTING HAND    "
      puts "====================="

      hand = @decklist.sample(@cards_in_hand)
      hand.each do |card|
        puts card.cmc + " | " + card.mana_symbols + " | " + card.name + " | " + card.type
      end

      puts "====================="
      hand_analysis(hand)
      puts "====================="
    end

    def self.hand_analysis(hand)
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

    def self.mulligan
      if @cards_in_hand <= 1
        puts "you can't mulligan anymore. No cards in hand !"
      else
        @cards_in_hand -= 1
      MtgHand::Deck.hand
      end
    end

  end

  class Card
    attr_accessor :cmc, :mana_symbols, :name, :type
  end

end
