import  Foundation
let path = "/Users/bridgelabz/Documents/Pratik/Swift_OOP_Programs/roughwork/roughwork/data.json"
var data3 = [Doctor]()
do{
    let decoder = JSONDecoder()
    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [[String:Any]]
    for i in 0..<jsonResult.count{
        if let jsonObject = jsonResult[i] as? [String:Any]{
            let data2 = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
           let obj = try decoder.decode(Doctor.self, from: data2)
            data3.append(obj)
        }
    }
}
catch{
    print("Error occured.")
}
for i in 0..<data3.count{
    print(data3[i].id)
}
