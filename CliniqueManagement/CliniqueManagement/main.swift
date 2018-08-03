import  Foundation
let manager:CliniqueManagerProtocol = CliniqueManager()
var x = 0
repeat{
    
    print("-------Clinique Management--------")
    print("1.Add Doctor.")
    print("2.Take Appointment.")
    print("3.Search Doctor.")
    print("4.Search Patient.")
    print("5.Show all Doctors.")
    print("6.Show all Patients")
    print("7.Exit.")
    print("Choose your option.")
    let choice = readLine()!
    if let choice = Int(choice){
        x = choice
        switch(choice){
        case 1:
            manager.addDoctor()
            break
        case 2:
            manager.takeAppointment()
            break
        case 3:
            manager.searchDoctor()
            break
        case 4:
            manager.searchPatient()
            break
        case 5:
            manager.showDoctors()
            break
        case 6:
            manager.showPatients()
            break
        case 7:
            break
        default:
            print("Enter the correct choice.")
        }
    }else{
        print("Enter an Integer value.")
    }
    
}while x != 7
