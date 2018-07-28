class Address{
    var state:String?
    var city:String?
    var zip:String?
    
    func setState(state:String)  {
        self.state = state
    }
    func setCity(city:String){
        self.city = city
    }
    func setZip(zip:String) {
        self.zip = zip
    }
    func getState()->String{
        return state!
    }
    func getCity() -> String {
        return city!
    }
    func getZip() -> String {
        return zip!
    }
    func toString() -> String {
        return "Address :['City':\(city!) 'state':\(state!) 'zip':\(zip!)]"
    }
}
