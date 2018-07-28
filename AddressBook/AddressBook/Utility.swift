import  Foundation


class Utility{
    let path = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/AddressBook/AddressBook/AddressBook.json"
    let person = Person()
    let address = Address()
    let main = Main()
    func getnumber()->Int{
        if let number = readLine(){
            if let number = Int(number){
                return number
            }
            else{
                print("Enter the Integer value.")
            }
        }
        return 0
    }
    func addPerson()  {
        print("Enter the First name of person. ")
        person.setFirstName(firstName: readLine()!)
        print("Enter the Last name of Person.")
        person.setLastName(lastName: readLine()!)
        print("Enter the phone number of person.")
        person.setPhonNum(phoneNum: getnumber())
        print("Enter the address.")
        print("Enter city.")
        address.setCity(city: readLine()!)
        print("Enter State.")
        address.setState(state: readLine()!)
        print("Enter Zip.")
        address.setZip(zip: readLine()!)
        person.setAddress(address: address.toString())
        //print(person.getFirstName())
        addPersonToFile()
        main.addressBook()
    }
   
    func addPersonToFile(){
        let previousData:[String:Any] = readData() as! [String:Any]
        var addressInfo:[String:Any] = [:]
        var  info = [String:Any]()
        info["First Name"] = person.getFirstName()
        info["Last Name"] = person.getLastName()
        info["Phone number"] = person.getPhonNum()
        addressInfo["City"] = address.getCity()
        addressInfo["State"] = address.getState()
        addressInfo["Zip"] = address.getZip()
        info["Address"] = addressInfo
        var newData:[String:Any] = previousData
        newData["\(person.getFirstName())"] = info
        do{ let personData = try JSONSerialization.data(withJSONObject: newData, options: .prettyPrinted)
            try personData.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
        }
        catch{
            print("Some error occured.")
        }
    }
    
    func readData()->Any{
        do{ let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
        return jsonResult
        }
        catch{
            print("Error occured.")
        }
        return 0
    }
    
    func removePerson() {
        var data:[String:Any] = readData() as! [String : Any]
        for (key,value) in data {
            print(key)
        }
        print("Enter the name of person to remove.")
        let name:String = readLine()!
        data.removeValue(forKey: name)
        print("The data of \(name) removed successfully.")
        let newData = data
        writeData(data:newData)
        main.addressBook()
    }
    
    func writeData(data:[String:Any])  {
        do {
            var newData:[String:Any] = readData() as! [String : Any]
            let personData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            try personData.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
        }
        catch{
            print("Some error occured.")
        }
    }
    func editPerson() {
        var data:[String:Any] = readData() as! [String : Any]
        for (key,value) in data {
            print(key)
        }
        print("Enter the name you want to edit the info of")
        let name:String = readLine()!
        for (key,value) in data{
            if key == name{
                if let info:[String:Any] = value as? [String:Any]
                {
                    var newData:[String:Any] = info
                    print("\n")
                    print("What do you want to edit about \(key).")
                    print("1. Phone Number.")
                    print("2. City.")
                    print("3. State.")
                    print("4. Zip.")
                    print("\n")
                    let choice = getnumber()
                    switch choice{
                    case 1: for (key,value) in newData{
                        if key == "Phone number"{
                            print("Enter the new Phone Number.")
                            newData["Phone number"] = getnumber()
                            data["\(name)"] = newData
                            writeData(data: data)
                            print("Phone number changed successfully.")
                            }
                        }
                    case 2:
                        for (key,value) in newData{
                            if key == "Address"{
                                if let addressInfo:[String:Any] = value as? [String:Any]{
                                    var addressData:[String:Any] = addressInfo
                                    for (key,value) in addressData{
                                        if key == "City"{
                                            print("Enter the new city Name.")
                                            addressData["City"] = readLine()!
                                            newData["Address"] = addressData
                                            data["\(name)"] = newData
                                            writeData(data: data)
                                            print("City name changed successfully.")
                                        }
                                    }
                                }
                            }
                        }
                    case 3:
                        for (key,value) in newData{
                            if key == "Address"{
                                if let addressInfo:[String:Any] = value as? [String:Any]{
                                    var addressData:[String:Any] = addressInfo
                                    for (key,value) in addressData{
                                        if key == "State"{
                                            print("Enter the new State Name.")
                                            addressData["State"] = readLine()!
                                            newData["Address"] = addressData
                                            data["\(name)"] = newData
                                            writeData(data: data)
                                            print("State name changed successfully.")
                                        }
                                    }
                                }
                            }
                        }
                    case 4:
                        for (key,value) in newData{
                            if key == "Address"{
                                if let addressInfo:[String:Any] = value as? [String:Any]{
                                    var addressData:[String:Any] = addressInfo
                                    for (key,value) in addressData{
                                        if key == "Zip"{
                                            print("Enter the new Zip code.")
                                            addressData["Zip"] = readLine()!
                                            newData["Address"] = addressData
                                            data["\(name)"] = newData
                                            writeData(data: data)
                                            print("Zip code changed successfully.")
                                        }
                                    }
                                }
                            }
                        }
                    default: print("Enter the correct choice")
                    }
                }
            }
        }
        main.addressBook()
    }
    
    func openInfo()  {
         var f = 0
        let data:[String:Any] = readData() as! [String : Any]
        for (key,value) in data {
            print(key)
        }
        print("Enter the name to open the information.")
        let name:String = readLine()!
        print("\n")
        for (key,value) in data{
            if key == name {
                f += 1
                if let info:[String:Any] = value as? [String:Any]
                {
                       for (key,value) in info{
                        if key != "Address"
                       {
                        print("\(key) = \(value)")
                        }else{
                            print("Address is :")
                            if let address:[String:Any] = value as? [String:Any]{
                                for (key,value) in address{
                                print("\t\t\t\t\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
            }
        }
        if f == 0{
            print("Enter the correct name.")
        }
        print("\n")
        main.addressBook()
    }
    
    func sortByName()  {
        
        let data:[String:Any] = readData() as! [String:Any]
        var nameArray = [String]()
        for (key,value) in data{
            nameArray.append(key)
        }
        nameArray.sort()
        for index in 0..<nameArray.count{
                  print(nameArray[index])
        }
        main.addressBook()
    }
    
    func sortByZip()  {
        let data:[String:Any] = readData() as! [String:Any]
        var zipArray = [String]()
        for(key,value) in data{
            if let info:[String:Any] = value as? [String:Any]
                {
                    for (key,value) in info{
                        if key == "Address"{
                            if let addressData:[String:Any] = value as? [String:Any]{
                                for(key,value) in addressData{
                                    if key == "Zip"{
                                        zipArray.append(value as! String)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        zipArray.sort()
        for index in 0..<zipArray.count {
            print(zipArray[index])
        }
        main.addressBook()
        }
}
