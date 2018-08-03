import Foundation

class Item:Codable{
    let name:String
    let price:Int
    let quantity:Int
    
    init(name:String,price:Int,quantity:Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}


class Rice:Item{
    
}

class Pulse:Item {
    
}

class Wheat:Item {
    
}
