import  Foundation
protocol CliniqueManagerProtocol {
    func addDoctor()
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
    func addDoctor() {
        var doctor = Doctors()
        print("Enter the name of Doctor:")
        doctor.name = readLine()!
        print("Enter the Id of the Doctor.")
        doctor.id = getnumber()
        print("Enter the specialization of Doctor.")
        doctor.specialization = readLine()!
        print("Enter the availability of Doctor:'AM','PM'or'Both'")
        let input = readLine()!
        if(input == "AM"||input == "PM"||input == "Both"){
        doctor.availability = input
        }else{
            print("Enter the correct availability")
        }
        let utility = Utility<Doctors>()
        var data = utility.readData(path: Constants.pathDoctors)
        data.append(doctor)
        utility.writeData(path: Constants.pathDoctors, data: data)
        print("Doctor with name \(doctor.name!) added.")
    }
    
    func addPatient(id :Int) {
        var patient = Patient()
        print("Enter the name of Patient.")
        patient.name = readLine()!
        print("Enter the id of Patient.")
        patient.id = id
        print("Enter the mobile number of Patient.")
        patient.mobileNo = getnumber()
        print("Enter the age of Patient.")
        patient.age = getnumber()
        let utility = Utility<Patient>()
        var data = utility.readData(path: Constants.pathPatients)
        data.append(patient)
        utility.writeData(path: Constants.pathPatients, data: data)
        print("\nPatient with name \(patient.name!) added successfully.\n")
    }
    
    func takeAppointment() {
        var appointment = Appointment()
        let utilityD = Utility<Doctors>()
        let utilityA = Utility<Appointment>()
        var idArray = [Int]()
        let data = utilityD.readData(path: Constants.pathDoctors)
        print("Doctors with these id's are available:")
        for index in 0..<data.count{
            print("\(data[index].id!)---\(data[index].name!)")
            idArray.append(data[index].id!)
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
            }else{
                print("Enter the valid date in format.")
                return
            }
        print("Enter the patient ID.")
        appointment.patientId = getnumber()
        var count:Int = 0
        var dataAppointment = utilityA.readData(path: Constants.pathAppointments)
        if dataAppointment.count == 0{
            dataAppointment.append(appointment)
            utilityA.writeData(path: Constants.pathAppointments, data: dataAppointment)
        }else{
            for index in 0..<dataAppointment.count{
                if dataAppointment[index].doctorId! == id && dataAppointment[index].date! == date{
                    count += 1
                }
            }
            if count < 5{
                addPatient(id : appointment.patientId!)
                dataAppointment.append(appointment)
                utilityA.writeData(path: Constants.pathAppointments, data: dataAppointment)
                print("\nYour appintment with the doctor has been added.\n")
            }else{
                print("All the 5 appointments of this doctor has been taken.")
            }
        }
        }else{
            print("Enter the valid doctor ID.")
            return
        }
    }
    func searchDoctor(){
        var j = 0
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
                let utility = Utility<Doctors>()
                let list = utility.readData(path: Constants.pathDoctors)
                for i in 0..<list.count{
                    if list[i].id == id{
                        print("Name  = ",list[i].name!)
                        print("Id  = ",list[i].id!)
                        print("Availability  = ",list[i].availability!)
                        print("Specialization  = ",list[i].specialization!)
                    }
                }
                
            }else{
                print("Enter the integer value.")
            }
            break
        case "2":
            print("Enter the name of doctor you want to search.")
            let name = readLine()!
            let utility = Utility<Doctors>()
            let list = utility.readData(path: Constants.pathDoctors)
            for i in 0..<list.count{
                if list[i].name == name{
                    j += 1
                    print("Name  = ",list[i].name!)
                    print("Id  = ",list[i].id!)
                    print("Availability  = ",list[i].availability!)
                    print("Specialization  = ",list[i].specialization!)
                }
            }
            if  j == 0{
                print("Doctor with the entered name does not exist.")
            }
            break
        case "3":
            print("Enter the specializatin of doctor you want to search.")
            let specialization = readLine()!
            let utility = Utility<Doctors>()
            let list = utility.readData(path: Constants.pathDoctors)
            for i in 0..<list.count{
                if list[i].specialization == specialization{
                    j += 1
                    print("Name  = ",list[i].name!)
                    print("Id  = ",list[i].id!)
                    print("Availability  = ",list[i].availability!)
                    print("Specialization  = ",list[i].specialization!)
                }
                print("\n")
            }
            if j == 0{
                print("Doctor with the entered specialization does not exist.")
            }
            break
        case "4":
            print("Enter the availability of doctor you want to search.")
            let availability = readLine()!
            let utility = Utility<Doctors>()
            let list = utility.readData(path: Constants.pathDoctors)
            for i in 0..<list.count{
                if list[i].availability == availability{
                    j += 1
                    print("Name  = ",list[i].name!)
                    print("Id  = ",list[i].id!)
                    print("Availability  = ",list[i].availability!)
                    print("Specialization  = ",list[i].specialization!)
                }
                print("\n")
            }
            if j == 0{
                print("Doctor with the entered availability does not exist.")
            }
            break
            
        default:
            print("Enter correct value.")
        }
    }
    
    func searchPatient() {
        var index = 0
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
                let utility = Utility<Patient>()
                let list = utility.readData(path: Constants.pathPatients)
                for i in 0..<list.count{
                    if list[i].id == id{
                        index += 1
                        print("Name  = ",list[i].name!)
                        print("Id  = ",list[i].id!)
                        print("Mobile Number  = ",list[i].mobileNo!)
                        print("Age  = ",list[i].age!)
                    }
                }
                if index == 0{
                    print("Patient with entered id deos not exist.")
                }
                
            }else{
                print("Enter the integer value.")
            }
            break
        case "2":
            print("Enter the name of Patient you want to search.")
            let name = readLine()!
            let utility = Utility<Patient>()
            let list = utility.readData(path: Constants.pathPatients)
            for i in 0..<list.count{
                if list[i].name == name{
                    index += 1
                    print("Name  = ",list[i].name!)
                    print("Id  = ",list[i].id!)
                    print("Mobile Number  = ",list[i].mobileNo!)
                    print("Age  = ",list[i].age!)
                }
                print("\n")
            }

            if index == 0{
                print("Patient with the entered name does not exist.")
            }

            break
        case "3":
            print("Enter the mobile number of Patient you want to search.")
            let mobileNo = readLine()!
            let utility = Utility<Patient>()
            let list = utility.readData(path: Constants.pathPatients)
            for i in 0..<list.count{
                if list[i].mobileNo == Int(mobileNo){
                    index += 1
                    print("Name  = ",list[i].name!)
                    print("Id  = ",list[i].id!)
                    print("Mobile Number  = ",list[i].mobileNo!)
                    print("Age  = ",list[i].age!)
                }
                print("\n")
            }
            if index == 0{
                print("Patient with the entered mobile number does not exist.")
            }

            break
        case "4":
            print("Enter the age of patient you want to search.")
            let age = readLine()!
            let utility = Utility<Patient>()
            let list = utility.readData(path: Constants.pathPatients)
            for i in 0..<list.count{
                if list[i].age == Int(age){
                    index += 1
                    print("Name  = ",list[i].name!)
                    print("Id  = ",list[i].id!)
                    print("Mobile Number  = ",list[i].mobileNo!)
                    print("Age  = ",list[i].age!)
                }
                print("\n")
            }
            if index == 0{
                print("Patient with the entered age does not exist.")
            }

            break
        default:
            print("Enter the correct value.")

        }

    }
    func showDoctors() {
        let utility = Utility<Doctors>()
        let list = utility.readData(path: Constants.pathDoctors)
        for i in 0..<list.count{
                print("Name  = ",list[i].name!)
                print("Id  = ",list[i].id!)
                print("Availability  = ",list[i].availability!)
                print("Specialization  = ",list[i].specialization!)
                print("\n")
        }
        
    }
    func showPatients() {
        let utility = Utility<Patient>()
        let list = utility.readData(path: Constants.pathPatients)
        for i in 0..<list.count{
                print("Name  = ",list[i].name!)
                print("Id  = ",list[i].id!)
                print("Mobile Number  = ",list[i].mobileNo!)
                print("Age  = ",list[i].age!)
                print("\n")
        }
    }
    
    
}
