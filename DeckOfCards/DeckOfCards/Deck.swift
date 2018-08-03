import Foundation


class Deck{
    
    func createDeck() -> [String] {
        let ranks = [Rank.Ace, Rank.Two, Rank.Three, Rank.Four, Rank.Five, Rank.Six, Rank.Seven, Rank.Eight, Rank.Nine, Rank.Ten, Rank.Jack, Rank.Queen, Rank.King]
        let suits = [Suit.Spades, Suit.Hearts, Suit.Diamonds, Suit.Clubs]
        var deck = [Card]()
        for suit in suits {
            for rank in ranks {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        var deckArray = [String]()
        for i in 0..<deck.count{
            deckArray.append(deck[i].simpleDescription())
        }
        return deckArray
    }
    
    func rand()->CGFloat{
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func shuffleCards(deck:[String]) -> [String] {
        var shuffledCards = deck
        for i in 0..<52{
            let index = Int(rand() * 52)
            let temp = shuffledCards[index]
            shuffledCards[index] = shuffledCards[i]
            shuffledCards[i] = temp
        }
        return shuffledCards
    }
    
    func spreadCards(cards : [String]) {
        var i = 0
        var cardArray = [[String]]()
        for _ in 0..<4{
            var newCardArray = [String]()
            for _ in 0..<9{
                newCardArray.append(cards[i])
                i = i+1
            }
            cardArray.append(newCardArray)
        }

        for index in 0..<4{
            print("Player \(index+1) has cards:")
            for index1 in 0..<9{
                print(cardArray[index][index1])
            }
            print("\n")
        }

    }
}
