require 'csv'

module MtgHand
  class Deck
    def self.read(file)
      list = CSV.read(file, headers: true)
      puts list
    end
  end
end
