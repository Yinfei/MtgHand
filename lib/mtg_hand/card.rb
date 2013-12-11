module MtgHand

  class Card
    attr_accessor :cmc, :mana_symbols, :name, :type

    def initialize(hash={})
      @cmc  = hash["CMC"]
      @mana_symbols = hash["Mana symbols"].to_s
      @name = hash["name"]
      @type = hash["type"]
    end

  end
end
