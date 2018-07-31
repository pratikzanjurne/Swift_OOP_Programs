
import  Foundation

let command:AddressBookManagerProtocol = AddressBookManager()
var number:Int = 0
repeat{
print("---------Welcome To Address Book----------")
print("1. Open Address book.")
print("2. Create Address book.")
print("3. Exit")
print("Enter your choice.")
    if let choice = readLine(){
    if let choice = Int(choice){
        number = choice
        switch choice{
        case 1:
            command.openAddressBook()
            
            break;
        case 2:
            command.createAddressBook();
            break;
        case 3:
            break
        default:
            print("Enter the correct choice.")
        }
    }else{
        print("Enter the integer value.")
    }
}
}while (number != 3)

