import Foundation

var path = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/InventoryManagement/InventoryManagement/Inventory.json"
protocol InventoryManagerProtocol {
    func calculateValue()
}

class InventoryManager: InventoryManagerProtocol {
    func addObject() {
        var inventory = Inventory()
        print("Enter the name.")
        inventory.name = readLine()!
        print("Enter the weight.")
        inventory.weight = getnumber()
        print("Enter the price pr Kg.")
        inventory.pricePerKg = getnumber()
        var data = readData()
        data.append(inventory)
        writeData(dataArray: data)
    }
    
    func calculateValue() {
        print("Enter the name to calcuate value.")
        let name = readLine()!
        var data = readData()
        for i in 0..<data.count{
            if data[i].name == name{
                let value = data[i].pricePerKg! * data[i].weight!
                print("Value of inventory is:",value)
                print("\n")
            }
        }
    }
    
    func readData()->[Inventory]{
        var dataArray = [Inventory]()
        let decoder = JSONDecoder()
        do{
            let jsonData = try Data(contentsOf:URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! [[String:Any]]
            for i in 0..<jsonResult.count{
                let jsonObject = jsonResult[i]
                let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                let arrayObject = try decoder.decode(Inventory.self, from: data)
                dataArray.append(arrayObject)
            }
        }catch{
            print("Error occured.")
        }
        return dataArray
    }
    
    func writeData(dataArray:[Inventory]) {
        var jsonData = [[String:Any]]()
        let encoder = JSONEncoder()
        do{
            for i in 0..<dataArray.count{
                let dataObject = dataArray[i]
                let data = try encoder.encode(dataObject)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
                jsonData.append(jsonResult)
            }
            let allData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
           try allData.write(to: URL(fileURLWithPath:path), options: .atomicWrite)
        }catch{
            print("Error occured.")
        }
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
