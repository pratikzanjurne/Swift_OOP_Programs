import  Foundation
let manager:CliniqueManagerProtocol = CliniqueManager()
var x = 0
repeat{
    
    print("-------Clinique Management--------")
    print("1.Add Doctor.")
    print("2.Add Patient.")
    print("3.Take Appointment.")
    print("4.Search Doctor.")
    print("5.Search Patient.")
    print("6.Show all Doctors.")
    print("7.Show all Patients")
    print("8.Exit.")
    print("Choose your option.")
    let choice = readLine()!
    if let choice = Int(choice){
        x = choice
        switch(choice){
        case 1:
            manager.addDoctor()
            break
        case 2:
            manager.addPatient()
            break
        case 3:
            manager.takeAppointment()
            break
        case 4:
            manager.searchDoctor()
            break
        case 5:
            manager.searchPatient()
            break
        case 6:
            manager.showDoctors()
            break
        case 7:
            manager.showPatients()
            break
        case 8:
            break
        default:
            print("Enter the correct choice.")
        }
    }else{
        print("Enter an Integer value.")
    }
    
}while x != 8
