import Foundation

class Main{

func addressBook(){
    let utility = Utility()
    print("1. Open person information.")
    print("2. Add a Person.")
    print("3. Remove a Person. ")
    print("4. Sort by name.")
    print("5. Sort by zip.")
    print("6. Edit person. ")
    print("7. Exit")
    print("Enter the choice.")
    if let choice = readLine(){
        if let choice = Int(choice){
            switch choice{
            case 1: utility.openInfo()
            case 2: utility.addPerson()
            case 3: utility.removePerson()
            case 4: utility.sortByName()
            case 5: utility.sortByZip()
            case 6: utility.editPerson()
            case 7: break
            default:
                print("Enter the correct choice.")
            }
        }
            else {
                print("Enter an integer value.")
            }
    }
}
}
let runAddressBook = Main()
runAddressBook.addressBook()
