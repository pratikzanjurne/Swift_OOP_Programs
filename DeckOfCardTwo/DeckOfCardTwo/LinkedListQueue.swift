import Foundation

class QueueLinkedList<T>{
    var start:Node<T>?
    
    func insertCard(card : T) {
        if self.start == nil{
            self.start = Node(card: card)
        }
        else
        {
            var lastNode = self.start
            while lastNode?.nextLink != nil{
                lastNode = lastNode?.nextLink
            }
            let newNode = Node(card: card)
            lastNode?.nextLink = newNode
        }
        
    }
    
    func getCard() -> T? {
        if self.start == nil{
            Swift.print("Queue is empty...")
        }
        else{
            let dataNode = self.start
            let card = dataNode?.card
            self.start = dataNode?.nextLink
            return card
        }
        return nil
    }
}

class Node<T> {
    var card:T
    var nextLink:Node<T>?
    
    init(card:T){
        self.card = card
    }
}

