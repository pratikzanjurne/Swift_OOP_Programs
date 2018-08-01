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
        var dataAppointment:[String:Any] = readData(path: Constants.pathAppointments) as! [String:Any]
//        let data1 = "{}"
//        let data2 = Data(base64Encoded: data1)
//        dataAppointment["\(doctor.id!)"] = data2
//        writeData(data: dataAppointment, path: Constants.pathAppointments)
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
        var i = 0
        var appointment = Appointment()
        var data:[String:Any] = readData(path: Constants.pathDoctors) as! [String : Any]
        print("Doctors with these id's are available:")
        for (key,value) in data{
            print(key)
        }
        print("Enter the doctor Id and date of appointment.")
        print("Enter the Doctor Id")
        appointment.doctorId = getnumber()
        print("Enter the date of appointment in format dd-mm-yyyy.")
        let date = readLine()!
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        if dateFormatterGet.date(from: date) != nil {
            appointment.date = date
            print(date)
        } else {
            print("Enter the valid date in format.")
        }
        print("Enter the patient ID.")
        appointment.patientId = getnumber()
        var info = [String:Any]()
        info["patientId"] = appointment.patientId
        var dataAppointment:[String:Any] = readData(path: Constants.pathAppointments) as! [String:Any]
        if dataAppointment.count == 0{
           // print("No doctors available.")
            var info = [String:Any]()
            info["patientId"] = appointment.patientId
            var dateInfo = [[String:Any]]()
            dateInfo.append(info)
            var doctorIdInfo = [String:Any]()
            doctorIdInfo["\(appointment.date!)"] = dateInfo
            dataAppointment["\(appointment.doctorId!)"] = doctorIdInfo
            writeData(data: dataAppointment, path: Constants.pathAppointments)
        }else{
        for (key,value) in dataAppointment{
            if key == "\(appointment.doctorId!)"{
                i += 1
                if let value1:[String:Any] = value as? [String:Any]
                {
                    var doctorIdInfo:[String:Any] = value1
                    var j = 0
                    for (key,value) in value1{
                        if key == "\(appointment.date!)"{
                            j += 1
                            if let value2:[[String:Any]] = value as? [[String:Any]]{
                                var dateInfo:[[String:Any]] = value2

                                if value2.count <= 5{
                                    var info = [String:Any]()
                                    info["patientId"] = appointment.patientId
                                    dateInfo.append(info)
                                    doctorIdInfo["\(appointment.date!)"] = dateInfo
                                    dataAppointment["\(appointment.doctorId!)"] = doctorIdInfo
                                    writeData(data: dataAppointment, path: Constants.pathAppointments)
                                    
                                }else{
                                    print("Please enter the another date and take appointment.")
                                }
                            }
                        }
                    }
                    if j == 0
                    {
                            var info = [String:Any]()
                            info["patientId"] = appointment.patientId
                            var dateInfo = [[String:Any]]()
                            dateInfo.append(info)
                            doctorIdInfo["\(appointment.date!)"] = dateInfo
                            dataAppointment["\(appointment.doctorId!)"] = doctorIdInfo
                            writeData(data: dataAppointment, path: Constants.pathAppointments)
                    }
                }
            }
            }
            if i == 0
            {
                //print("Enter the correct doctor ID.")
                var info = [String:Any]()
                info["patientId"] = appointment.patientId
                var dateInfo = [[String:Any]]()
                dateInfo.append(info)
                var doctorIdInfo = [String:Any]()
                doctorIdInfo["\(appointment.date!)"] = dateInfo
                dataAppointment["\(appointment.doctorId!)"] = doctorIdInfo
                writeData(data: dataAppointment, path: Constants.pathAppointments)
            }
            
        
    }
        
    }
}
