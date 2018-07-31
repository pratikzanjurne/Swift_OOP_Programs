import  Foundation
protocol AddressBookManagerProtocol {
    func openAddressBook()
    func createAddressBook()
    func addressBook(name:String)
}

class AddressBookManager:AddressBookManagerProtocol {
    
    
    func createAddressBook() {
        let initialString:String = "{}"
        let data = initialString.data(using: .utf8)
        print("Enter the name of address book.")
        let name = readLine()!
        let path = "\(Constants.folderPath)/\(name).json"
        if FileManager().createFile(atPath: path, contents: data, attributes: nil){
                 print("Address book created with name \(name).")
        }else{
            print("Can't create the address book.")
        }
    }
    
     func openAddressBook() {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath:         Constants.folderPath)
            //print(files)
            for file in files{
                var data =  file
                data.removeLast(5)
                print(data)
             }
            print("Enter the name of addressbook.")
            let name = readLine()!
            if FileManager.default.fileExists(atPath: "\(Constants.folderPath)/\(name).json")
            {
                 addressBook(name: name)
            }else{
                print("Not found.")
            }
        }catch{
        print("cant display files.")
        }
    }
    
    func addressBook(name:String){
        let book:AddressBookProtocol = AddressBook(fileName: name)
        var number:Int = 0
        repeat{
            
        print("------WELCOME TO ADDRESS BOOK--------")
        print("1. Open informatiom of person.")
        print("2. Add a Person.")
        print("3. Remove a Person. ")
        print("4. Sort by name.")
        print("5. Sort by zip.")
        print("6. Edit person. ")
        print("7. Save")
        print("8. Exit")
        print("Enter the choice.")
        if let choice = readLine(){
            if let choice = Int(choice){
                number = choice
                switch choice{
                case 1:
                    book.openInfo()
                    break
                case 2:
                    book.addPerson()
                    break
                case 3:
                    book.removePerson()
                    break
                case 4:
                    book.sortByName()
                    break
                case 5:
                    book.sortByZip()
                    break
                case 6:
                    book.editPerson()
                    break
                case 7:
                    book.saveFile()
                    break
                case 8:
                    break;
                default:
                    print("Enter the correct choice.")
                }
            }
            else {
                print("Enter an integer value.")
            }
        }
    }while (number != 8)

 }
}
