import RxCocoa
import RxSwift
import Foundation

struct DateFieldViewModel: FieldViewModel {
    var title: String = "Date of your Birth"
    
    var errorMessage: String = "Wrong Date"
    
    var value: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func validate() -> Bool {
        let dateOfBirth = value.value ?? ""
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let currentDateString = dateFormatter.string(from: todayDate)
        
        let cDate = dateFormatter.date(from: dateOfBirth)
        
        if dateOfBirth == "" {
            return false
        }
        
        if !(cDate! < todayDate || dateOfBirth == currentDateString) {
            errorValue.accept(errorMessage)
            return false
        } else {
            return true
        }
    }
    
    
}
