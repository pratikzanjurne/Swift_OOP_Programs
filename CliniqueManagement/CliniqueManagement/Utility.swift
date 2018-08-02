import  Foundation


class Utility<T:Codable>{
    
    
     func readData(path:String)->[T] {
        do {
            var objectArray = [T]()
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! [[String:Any]]
            for i in 0..<jsonResult.count{
                 let jsonObject = jsonResult[i]
                 let data = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
                 let object = try decoder.decode(T.self, from: data)
                 objectArray.append(object)
            }
            return objectArray
        }
        catch{
            print("Error occured.")
        }
        return []
    }
    
    func writeData(path:String,data:[T]) {
        do{
            var jsonData = [[String:Any]]()
            let encoder = JSONEncoder()
            for i in 0..<data.count{
                let object = data[i]
                let dataArray =  try encoder.encode(object)
                let jsonResult = try JSONSerialization.jsonObject(with: dataArray, options: .mutableLeaves) as! [String:Any]
                jsonData.append(jsonResult)
            }
            let allData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            try allData.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
        }catch{
            print("Error occured.")
        }
    }
    
    
}
