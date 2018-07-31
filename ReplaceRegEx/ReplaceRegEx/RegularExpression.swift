import Foundation
class RegularExpression{
    let filePath = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/ReplaceRegEx/ReplaceRegEx/data.txt"
    
    func getNumber()->Int{
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
    
    func readData() -> String {
        do{
            let fileData = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
         
            return fileData
        }
        catch{
            print("Error")
        }
        return ""
    }
    
    func replaceData(name:String,fullName:String,PhNo:Int,data:String)-> String{
        
        let str = data.replacingOccurrences(of: "<<name>>", with: "\(name)", options: .regularExpression)
        let str1 = str.replacingOccurrences(of: "<<full name>>", with: "\(fullName)", options: .regularExpression)
        let str2 = str1.replacingOccurrences(of: "91­xxxxxxxxxx", with: "\(PhNo)", options: .regularExpression)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        let str3 = str2.replacingOccurrences(of: "01/01/2016", with: "\(result)", options: .regularExpression)
        return str3
    }

    
    func writeDate(data:String)  {
        do {
            try data.write(toFile: filePath, atomically: false, encoding: .utf8)
        }
        catch{
            print("Error occured.")
        }
    }
    
    
}
