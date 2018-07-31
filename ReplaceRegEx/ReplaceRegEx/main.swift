import Foundation

let utility = RegularExpression()
var fileData = utility.readData()
print("Enter the name.")
var name:String = readLine()!
print("Enter Full name.")
var fullName:String = readLine()!
print("Enter Phone Number.")
var number:Int = utility.getNumber()
let replacedData:String = utility.replaceData(name: name, fullName: fullName, PhNo: number, data: fileData)
utility.writeDate(data: replacedData)
print("Date replaced successfully.")
