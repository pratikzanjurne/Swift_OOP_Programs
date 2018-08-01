import  Foundation
protocol CliniqueManagerProtocol {
    func addDoctor()
    func addPatient()
    func takeAppointment()
    func searchDoctor()
    func searchPatient()
    func showDoctors()
    func showPatients()
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
        var i = 0
        var appointment = Appointment()
        var idArray = [Int]()
        var data:[String:Any] = readData(path: Constants.pathDoctors) as! [String : Any]
        print("Doctors with these id's are available:")
        for (key,value) in data{
            print(key)
            idArray.append(Int(key)!)
        }
        print("Enter the doctor Id and date of appointment.")
        print("Enter the Doctor Id")
        let id = getnumber()
        if idArray.contains(id){
            appointment.doctorId = id
            print("Enter the date of appointment in format dd-mm-yyyy.")
            let date = readLine()!
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyyy"
            if dateFormatterGet.date(from: date) != nil {
                appointment.date = date
            } else {
                print("Enter the valid date in format.")
                return
        }
        print("Enter the patient ID.")
        appointment.patientId = getnumber()
        var info = [String:Any]()
        info["patientId"] = appointment.patientId
        var dataAppointment:[String:Any] = readData(path: Constants.pathAppointments) as! [String:Any]
        if dataAppointment.count == 0{
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
        }else{
            print("Enter the valid doctor ID.")
            return
        }
    }
    func searchDoctor(){
        var i = 0
        let data:[String:Any] = readData(path: Constants.pathDoctors) as! [String:Any]
        print("1. Search doctor by Id.")
        print("2. Search doctor by name.")
        print("3. Search doctor br specialization.")
        print("4. Search doctor by availability.")
        print("Give your choice.")
        let choice = readLine()!
        switch choice {
        case "1":
            print("Enter the Doctor Id.")
            let id = readLine()!
            if let id = Int(id){
                for (key,value) in data{
                    if key == "\(id)"{
                        i += 1
                        if let doctorData:[String:Any] = value as? [String:Any]{
                            for (key,value) in doctorData{
                                print("\(key)  = \(value)")
                            }
                        }
                    }
                }
                if i == 0{
                    print("Doctor with entered id deos not exist.")
                }
                
            }else{
                print("Enter the integer value.")
            }
            break
        case "2":
            print("Enter the name of doctor you want to search.")
            let name = readLine()!
            for (key,value) in data{
                if let doctorData:[String:Any] = value as? [String:Any]{
                    for(key,value) in doctorData{
                        if key == "name"{
                            if name == value as! String{
                                i += 1
                                for (key,value) in doctorData{
                                    print("\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
            }
            if i == 0{
                print("Doctor with the entered name does not exist.")
            }
            break
        case "3":
            print("Enter the specializatin of doctor you want to search.")
            let specialization = readLine()!
            for (key,value) in data{
                if let doctorData:[String:Any] = value as? [String:Any]{
                    for(key,value) in doctorData{
                        if key == "specialization"{
                            if specialization == value as! String{
                                i += 1
                                for (key,value) in doctorData{
                                    print("\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
                print("\n")
            }
            if i == 0{
                print("Doctor with the entered specialization does not exist.")
            }
            break
        case "4":
            print("Enter the availability of doctor you want to search.")
            let availability = readLine()!
            for (key,value) in data{
                if let doctorData:[String:Any] = value as? [String:Any]{
                    for(key,value) in doctorData{
                        if key == "availability"{
                            if availability == value as! String{
                                i += 1
                                for (key,value) in doctorData{
                                    print("\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
                print("\n")
            }
            if i == 0{
                print("Doctor with the entered availability does not exist.")
            }
            break
            
        default:
            print("Enter correct value.")
        }
    }
    
    func searchPatient() {
        var i = 0
        var data:[String:Any] = readData(path: Constants.pathPatients) as! [String:Any]
        print("1. Search patient by ID.")
        print("2. Search patient by name.")
        print("3. Search patient by mobile number.")
        print("4. Search patient by age.")
        print("Enter the choice.")
        let choice = readLine()!
        switch choice {
        case "1":
            print("Enter the Patient Id.")
            let id = readLine()!
            if let id = Int(id){
                for (key,value) in data{
                    if key == "\(id)"{
                        i += 1
                        if let patientData:[String:Any] = value as? [String:Any]{
                            for (key,value) in patientData{
                                print("\(key)  = \(value)")
                            }
                        }
                    }
                }
                if i == 0{
                    print("Patient with entered id deos not exist.")
                }
                
            }else{
                print("Enter the integer value.")
            }
            break
        case "2":
            print("Enter the name of Patient you want to search.")
            let name = readLine()!
            for (key,value) in data{
                if let patientData:[String:Any] = value as? [String:Any]{
                    for(key,value) in patientData{
                        if key == "name"{
                            if name == value as! String{
                                i += 1
                                for (key,value) in patientData{
                                    print("\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
            }
            if i == 0{
                print("Patient with the entered name does not exist.")
            }

            break
        case "3":
            print("Enter the mobile number of Patient you want to search.")
            let mobileNo = readLine()!
            for (key,value) in data{
                if let patientData:[String:Any] = value as? [String:Any]{
                    for(key,value) in patientData{
                        if key == "mobileNo"{
                            if mobileNo == "\(value)"{
                                i += 1
                                for (key,value) in patientData{
                                    print("\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
            }
            if i == 0{
                print("Patient with the entered mobile number does not exist.")
            }

            break
        case "4":
            print("Enter the age of patient you want to search.")
            let age = readLine()!
            for (key,value) in data{
                if let patientData:[String:Any] = value as? [String:Any]{
                    for(key,value) in patientData{
                        if key == "age"{
                            if age == "\(value)"{
                                i += 1
                                for (key,value) in patientData{
                                    print("\(key) = \(value)")
                                }
                            }
                        }
                    }
                }
            }
            if i == 0{
                print("Patient with the entered age does not exist.")
            }

            break
        default:
            print("Enter the correct value.")

        }

    }
    func showDoctors() {
        let data:[String:Any] = readData(path: Constants.pathDoctors) as! [String:Any]
        for (key,value) in data{
            if let doctorData:[String:Any] = value as? [String:Any]
            {
                for (key,value) in doctorData{
                    print("\(key) = \(value)")
                }
            }
            print("\n")
        }
    }
    func showPatients() {
        let data:[String:Any] = readData(path: Constants.pathPatients) as! [String:Any]
        for (key,value) in data{
            if let patientData:[String:Any] = value as? [String:Any]
            {
                for (key,value) in patientData{
                    print("\(key) = \(value)")
                }
            }
            print("\n")
        }
    }
    
    
}
