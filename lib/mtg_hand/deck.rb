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
end
