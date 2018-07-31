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
    print("6.Display Patient/Doctor")
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
            manager.addPatient()
            break
        case 3:
            manager.takeAppointment()
            break
        case 4:
            break
        case 5:
            break
        case 6:
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
