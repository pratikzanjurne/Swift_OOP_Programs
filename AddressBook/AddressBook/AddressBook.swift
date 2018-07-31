
import Foundation
protocol AddressBookProtocol {
    func addPerson()
    func openInfo()
    func removePerson()
    func sortByName()
    func sortByZip()
    func editPerson()
    func saveFile()
}

class AddressBook:AddressBookProtocol{
    
    
    let fileName:String?
    var person = Person()
    var address = Address()
    var allData = [String:Any]()
    //var allData = [String:Any]()
    init(fileName:String) {
         self.fileName = fileName
    }
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
        person.firstName = readLine()!
        print("Enter the Last name of Person.")
        person.lastName = readLine()!
        print("Enter the phone number of person.")
        person.phoneNum = readLine()!
        print("Enter the address.")
        print("Enter city.")
        address.city = readLine()!
        print("Enter State.")
        address.state = readLine()!
        print("Enter Zip.")
        address.zip = readLine()!
        person.address = address.toString()
        addPersonToFile()
        print("Person with name \(person.firstName!) added successfully.")
    }
    
    func addPersonToFile(){
        var previousData:[Any] = readData() as! [Any]
        var addressInfo:[String:Any] = [:]
        var  info:[String:Any] = [:]
        info["first_name"] = person.firstName
        info["last_name"] = person.lastName
        info["phone_number"] = person.phoneNum
        addressInfo["city"] = address.city
        addressInfo["state"] = address.state
        addressInfo["zip"] = address.zip
        info["address"] = addressInfo
        previousData.append(info)
        var newData:[Any] = []
        newData = previousData
       // newData["\(String(describing: person.firstName!))"] = info
       // allData.allData = newData
        //print(allData)
        print("Do you want to save this action.'y/n'")
        let rply = readLine()!
        if rply == "y"{
        saveFile()
            writeData(data: newData)
        }
    }
    
    func readData()->Any{
        do{ let data = try Data(contentsOf: URL(fileURLWithPath: "\(Constants.folderPath)/\(fileName!).json"), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [Any]
            return jsonResult
        }
        catch{
            print("Error occured.")
        }
        return 0
    }
    
    func removePerson() {
        var data:[Any] = readData() as! [Any]
        for datas in data {
            if let info:[String:Any] = datas as? [String:Any]
            {
                for(key,value) in info{
                    if key == "first_name"
                    {
                        print(value)
                    }
                }
            }
        }
        print("Enter the name of person to remove.")
        let name:String = readLine()!
        var i = -1
        for datas in data {
            if let info:[String:Any] = datas as? [String:Any]
            {
                i += 1
                for(key,value) in info{
                    if key == "first_name"
                    {
                        if name == value as! String{
                        data.remove(at: i)
                        }
                    }
                }
            }
        }
        print("The data of \(name) removed successfully.")
        let newData = data
        //allData.allData = newData
        writeData(data:newData)
    }
    
    func writeData(data:[Any])  {
        do {
            let personData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            try personData.write(to: URL(fileURLWithPath: "\(Constants.folderPath)/\(fileName!).json"), options: .atomicWrite)
        }
        catch{
            print("Some error occured.")
        }
    }
    func editPerson() {
        var data:[Any] = readData() as! [Any]
        for datas in data {
            if let info:[String:Any] = datas as? [String:Any]
            {
                for(key,value) in info{
                    if key == "first_name"
                    {
                        print(value)
                    }
                }
            }
        }
        print("Enter the name you want to edit the info of")
        var i = -1
        let name:String = readLine()!
        for datas in data{
            if let info:[String:Any] = datas as? [String:Any]
            {
                i += 1
                for (key,value) in info
                {
                    if key == "first_name"{
                        if name == value as! String
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
                                if key == "phone_number"{
                                    print("Enter the new Phone Number.")
                                    newData["phone_number"] = getnumber()
                                    //data["\(name)"] = newData
                                    //allData.allData = data
                                    data.remove(at: i)
                                    data.append(newData)
                                    writeData(data: data)
                                    print("Phone number changed successfully.")
                                }
                            }
                            case 2:
                                for (key,value) in newData{
                                    if key == "address"{
                                        if let addressInfo:[String:Any] = value as? [String:Any]{
                                            var addressData:[String:Any] = addressInfo
                                            for (key,value) in addressData{
                                                if key == "city"{
                                                    print("Enter the new city Name.")
                                                    addressData["city"] = readLine()!
                                                    newData["address"] = addressData
                                                    data.remove(at: i)
                                                    data.append(newData)
                                                    //allData.allData = data
                                                    writeData(data: data)
                                                    print("City name changed successfully.")
                                                }
                                            }
                                        }
                                    }
                                }
                            case 3:
                                for (key,value) in newData{
                                    if key == "address"{
                                        if let addressInfo:[String:Any] = value as? [String:Any]{
                                            var addressData:[String:Any] = addressInfo
                                            for (key,value) in addressData{
                                                if key == "state"{
                                                    print("Enter the new State Name.")
                                                    addressData["state"] = readLine()!
                                                    newData["address"] = addressData
                                                    data.remove(at: i)
                                                    data.append(newData)
                                                    //allData.allData = data
                                                    writeData(data: data)
                                                    print("State name changed successfully.")
                                                }
                                            }
                                        }
                                    }
                                }
                            case 4:
                                for (key,value) in newData{
                                    if key == "address"{
                                        if let addressInfo:[String:Any] = value as? [String:Any]{
                                            var addressData:[String:Any] = addressInfo
                                            for (key,value) in addressData{
                                                if key == "zip"{
                                                    print("Enter the new Zip code.")
                                                    addressData["zip"] = readLine()!
                                                    newData["address"] = addressData
                                                    data.remove(at: i)
                                                    data.append(newData)
                                                    //allData.allData = data
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
            }
        }
    }
    func openInfo()  {
        var f = 0
        let data:[Any] = readData() as! [Any]
        print("The address book contains following data: ")
        for datas in data {
            if let info:[String:Any] = datas as? [String:Any]
            {
                for(key,value) in info{
                    if key == "first_name"
                    {
                        print(value)
                    }
                }
            }
        }
        print("Enter the name to open the information.")
        let name:String = readLine()!
        print("\n")
        for datas in data{
        if let info:[String:Any] = datas as? [String:Any]
        {
        for (key,value) in info{
            if key == "first_name" {
                if name == value as? String {
                    f += 1
                    for (key,value) in info{
                        if key != "address"
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
    }
}
    
        if f == 0{
            print("Enter the correct name.")
            openInfo()
        }
        print("\n")
    }
    
    func sortByName()  {
        
        let data:[Any] = readData() as! [Any]
        var nameArray = [String]()
        var sortedData:[Any] = []
        for datas in data {
            if let info:[String:Any] = datas as? [String:Any]
            {
                for(key,value) in info{
                    if key == "first_name"
                    {
                        nameArray.append(value as! String)
                    }
                }
            }
        }
        nameArray.sort()
        //print(nameArray)
        for index in 0..<nameArray.count{
            for datas in data{
                if let info:[String:Any] = datas as? [String:Any]
                {
                    for (key,value) in info{
                        if key == "first_name"{
                            if nameArray[index] == value as! String{
                                sortedData.append(info)
                            }
                        }
                    }
                }
            }
        }
        //print(sortedData)
        writeData(data: sortedData)
    }
    
    func sortByZip()  {
        let data:[Any] = readData() as! [Any]
        var nameArray = [String]()
        var sortedData:[Any] = []
        for datas in data{
            if let info:[String:Any] = datas as? [String:Any]
            {
                for (key,value) in info{
                    if key == "address"{
                        if let addressInfo:[String:Any] = value as? [String:Any]{
                            var addressData:[String:Any] = addressInfo
                            for (key,value) in addressData{
                                if key == "zip"{
                                     nameArray.append(value as! String)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        
        nameArray.sort()
        //print(nameArray)
        for index in 0..<nameArray.count{
            for datas in data{
                if let info:[String:Any] = datas as? [String:Any]
                {
                    for (key,value) in info{
                        if key == "address"{
                            if let addressInfo:[String:Any] = value as? [String:Any]{
                                var addressData:[String:Any] = addressInfo
                                for (key,value) in addressData{
                                    if key == "zip"{
                                        if nameArray[index] == value as! String{
                                            sortedData.append(info)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        //print(sortedData)
        writeData(data: sortedData)
    }

    func saveFile() {
        //writeData(data: allData.allData, fileName: fileName)
    }
    
    
}
