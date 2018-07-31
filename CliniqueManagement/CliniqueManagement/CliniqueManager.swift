import  Foundation
protocol CliniqueManagerProtocol {
    func addDoctor()
    func addPatient()
    func takeAppointment()
}

class CliniqueManager: CliniqueManagerProtocol {
    func getnumber()->Int {
        let number = readLine()!
        if let number = Int(number){
            return number
        }else {
            print("Enter the integer value.")
        }
        return 0
    }
    func readData(path: String)->Any{
        do{ let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
            return jsonResult
        }
        catch{
            print("Error occured.")
        }
        return 0
    }
    func writeData(data:[String:Any],path:String)  {
        do {
            let personData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            try personData.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
        }
        catch{
            print("Some error occured.")
        }
    }

    func addDoctor() {
        var doctor = Doctor()
        print("Enter the name of Doctor:")
        doctor.name = readLine()!
        print("Enter the Id of the Doctor.")
        doctor.id = getnumber()
        print("Enter the specialization of Doctor.")
        doctor.specialization = readLine()!
        print("Enter the availability of Doctor:'AM','PM'or'Both'")
        var input = readLine()!
        if(input == "AM"||input == "PM"||input == "Both"){
        doctor.availability = input
        }else{
            print("Enter the correct availability")
        }
        var data:[String:Any] = readData(path: Constants.pathDoctors) as! [String:Any]
        var doctorInfo:[String:Any] = [:]
        doctorInfo["name"] = doctor.name
        doctorInfo["id"] = doctor.id
        doctorInfo["availability"] = doctor.availability
        doctorInfo["specialization"] = doctor.specialization
        data["\(doctor.id!)"] = doctorInfo as Any
        writeData(data: data, path: Constants.pathDoctors)
        print("Doctor with name \(doctor.name!) added successfully.")
    }
    
    func addPatient() {
        var patient = Patient()
        print("Enter the name of Patient.")
        patient.name = readLine()!
        print("Enter the id of Patient.")
        patient.id = getnumber()
        print("Enter the mobile number of Patient.")
        patient.mobileNo = getnumber()
        print("Enter the age of Patient.")
        patient.age = getnumber()
        var data:[String:Any] = readData(path: Constants.pathPatients) as! [String:Any]
        var patientInfo:[String:Any] = [:]
        patientInfo["name"] = patient.name
        patientInfo["id"] = patient.id
        patientInfo["age"] = patient.age
        patientInfo["mobileNo"] = patient.mobileNo
        data["\(patient.id!)"] = patientInfo as Any
        writeData(data: data, path: Constants.pathPatients)
        print("Doctor with name \(patient.name!) added successfully.")
    }
    
    func takeAppointment() {
        var appointment = Appointment()
        var data:[String:Any] = readData(path: Constants.pathDoctors) as! [String : Any]
        print("Doctors with these id's are available:")
        for (key,value) in data{
            print(key)
        }
        print("Enter the doctor Id and date of appointment.")
        print("Enter the Doctor Id")
        appointment.doctorId = getnumber()
        print("Enter the date of appointment")
        appointment.date = readLine()!
    }
}
