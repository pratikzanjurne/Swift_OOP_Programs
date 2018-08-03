import Foundation

var path = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/InventoryManagement/InventoryManagement/Inventory.json"
protocol InventoryManagerProtocol {
    func calculateValue()
}

class InventoryManager: InventoryManagerProtocol {
    
    func calculateValue() {
        print("Enter the name to calcuate value.")
        let name = readLine()!
        var data = readData(name:name)
        for i in 0..<data.count{
                let value = data[i].quantity * data[i].price
                print("Name--------",data[i].name)
                print("Quantity----",data[i].quantity)
                print("Price-------",data[i].price)
                print("Value of \(data[i].name) \(name) is:",value)
                print("\n")
            
        }
    }
    
    func readData(name:String)->[Item]{
        var dataArray = [Item]()
        let decoder = JSONDecoder()
        do{
            var jsonObject = [[String:Any]]()
            let jsonData = try Data(contentsOf:URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! [String:Any]
            for (key,value) in jsonResult{
                if key == "\(name)"{
                    if let jsonObject1:[[String:Any]] = value as? [[String:Any]]{
                        jsonObject = jsonObject1
                    }
                }
            }
            for i in 0..<jsonObject.count{
                let json = jsonObject[i]
                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let arrayObject = try decoder.decode(Item.self, from: data)
                dataArray.append(arrayObject)
            }
        }catch{
            print("Error occured.")
        }
        return dataArray
    }
    

    
    func getnumber()->Int {
        let number = readLine()!
        if let number = Int(number){
            return number
        }else {
            print("Enter the integer value.")
        }
        return 0
    }

    
}
