MtgHand
=======

A gem that generates random starting hands with a CSV file of your MTG Deck !

# Usage

In your terminal :
MtgHand::Deck.read("path/to/your/deck.csv")

* MtgHand::Deck.hand will generate a starting hand.
* mtgHand::Deck.mulligan will make a mulligan (generate another starting hand with one card less).
