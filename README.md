MtgHand
=======

A gem that generates random starting hands with a CSV file of your MTG Deck !

# Usage

Decks are saved in a MtgHand deck folder at "User/decks/"

In your terminal :
<tt>csv = MtgHand::Csv.read("path/to/your/deck.csv" OR "deckname")</tt> if saved on your MtgHand "decks" folder

Then : <tt>My_deck = MtgHand::Deck.new(csv)</tt> and you're ready to go !

* <tt>My_deck.hand</tt> will generate a starting hand of previously read deck.
* <tt>My_deck.mulligan</tt> will make a mulligan (generate another starting hand but with one less card).
* <tt>My_deck.save</tt> will save previously read deck into the MtgHand deck folder.
* <tt>My_deck.update</tt> will overwrite your previously saved file into the MtgHand deck folder.
