class Person{
    var firstName:String?
    var lastName:String?
    var phoneNum:Int?
    var address:String?
    
    func setFirstName(firstName:String)  {
        self.firstName = firstName
    }
    func getFirstName() -> String {
        return firstName!
    }
    func setLastName(lastName:String) {
        self.lastName = lastName
    }
    func getLastName() -> String {
        return lastName!
    }
    func setPhonNum(phoneNum:Int){
        self.phoneNum = phoneNum
    }
    func getPhonNum() -> Int {
        return phoneNum!
    }
    func setAddress(address:String)  {
        self.address = address
    }
    func toString()->String{
        return "Person"
    }
}
