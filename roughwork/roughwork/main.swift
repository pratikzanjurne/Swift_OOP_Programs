import  Foundation
var fileNameArray = [String]()
        do {
            let dataPath = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/AddressBook/AddressBook/AddressBooks"
            let files = try FileManager.default.contentsOfDirectory(atPath: dataPath)
            for file in files{
                var data =  file
                data.removeLast(5)
//                print(data)
                fileNameArray.append(data)
                for data in fileNameArray{
                print(data)
                }
           }
     }catch{
        print("cant display files.")
        }
        print("Enter the name of Address book to open.")
        var name = readLine()!
        let path = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/AddressBook/AddressBook/AddressBooks/\(name).json"
if (fileNameArray.contains(name)){
            print("found")
        }else{
            print("Enter correct name of address book")
        }

