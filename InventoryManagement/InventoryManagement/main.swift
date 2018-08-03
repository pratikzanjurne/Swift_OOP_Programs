import Foundation
var i = "0"
repeat{
    let manager:InventoryManagerProtocol = InventoryManager()
    print("-----Welcome to Inventory Management-------")
    print("1. Calculate total value.")
    print("2. Exit.")
    let choice = readLine()!
    i = choice
    switch choice{
    case "1":
        manager.calculateValue()
        break
    case "2":
        break
    default:
        print("Enter the correct choice.")
    }
}while i != "2"



