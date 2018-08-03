import Foundation

let deckClass = Deck()
let deck = deckClass.createDeck()
let shuffledCards = deckClass.shuffleCards(deck: deck)


deckClass.addToQueue(cards: shuffledCards)
deckClass.distributeCards()
deckClass.sortCards()
