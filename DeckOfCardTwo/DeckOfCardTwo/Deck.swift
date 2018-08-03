import Foundation


class Deck{
    var queueList = QueueLinkedList<Card>()
    var player1 : Player?
    var player2 : Player?
    var player3 : Player?
    var player4 : Player?
    func createDeck() -> [Card] {
        let ranks = [Rank.Ace, Rank.Two, Rank.Three, Rank.Four, Rank.Five, Rank.Six, Rank.Seven, Rank.Eight, Rank.Nine, Rank.Ten, Rank.Jack, Rank.Queen, Rank.King]
        let suits = [Suit.Spades, Suit.Hearts, Suit.Diamonds, Suit.Clubs]
        var deck = [Card]()
        for suit in suits {
            for rank in ranks {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        return deck
    }
    
    func rand()->CGFloat{
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func shuffleCards(deck:[Card]) -> [Card] {
        var shuffledCards = deck
        for i in 0..<52{
            let index = Int(rand() * 52)
            let temp = shuffledCards[index]
            shuffledCards[index] = shuffledCards[i]
            shuffledCards[i] = temp
        }
        return shuffledCards
    }
    
    func addToQueue(cards:[Card]) {
        for i in 0..<cards.count{
            queueList.insertCard(card:  cards[i])
        }
    }


    
    func distributeCards(){
        var player1Cards = [Card]()
        var player2Cards = [Card]()
        var player3Cards = [Card]()
        var player4Cards = [Card]()

        for _ in 0..<9{
            for j in 0..<4{
                switch j{
                case 0:
                    player1Cards.append(queueList.getCard()!)
                case 1:
                    player2Cards.append(queueList.getCard()!)
                case 2:
                    player3Cards.append(queueList.getCard()!)
                case 3:
                    player4Cards.append(queueList.getCard()!)

                default:
                    break
                }
            }
        }
        player1 = Player(cards: player1Cards)
        player2 = Player(cards: player2Cards)
        player3 = Player(cards: player3Cards)
        player4 = Player(cards: player4Cards)

    }

    func sortCards(){
        
        sort(player:player1!)
        //sort(player:player2!)
        //sort(player:player3!)
        //sort(player:player4!)
    }
    
    func sort(player:Player) {
        var playerCards = player.cards
        for index in 0..<playerCards.count{
            print(playerCards[index].simpleDescription())
//            for index1 in 0..<playerCards.count-index{
//                if
//            }
        }
        
    }

}

