struct Address:Codable{
    var state:String?
    var city:String?
    var zip:String?

    func toString() -> String {
        return "Address :['City':\(city!) 'state':\(state!) 'zip':\(zip!)]"
    }
}
