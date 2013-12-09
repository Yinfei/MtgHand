MtgHand
=======

A gem that generates random starting hands with a CSV file of your MTG Deck !

# Usage

In your terminal :
<tt>MtgHand::Deck.read("path/to/your/deck.csv")</tt>

* <tt>MtgHand::Deck.hand</tt> will generate a starting hand of previously read deck.
* <tt>MtgHand::Deck.mulligan</tt> will make a mulligan (generate another starting hand with one card less).
* <tt>MtgHand::Deck.save</tt> will save previously read deck into a "User/decks/" folder.
