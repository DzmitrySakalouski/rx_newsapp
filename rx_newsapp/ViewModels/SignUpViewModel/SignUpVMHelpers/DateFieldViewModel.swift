import RxCocoa
import RxSwift
import Foundation

struct DateFieldViewModel: FieldViewModel {
    var title: String = "Date of your Birth"
    
    var errorMessage: String = "Wrong Date"
    
    var value: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func validate() -> Bool {
        let dateOfBirth = value.value
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let currentDateString = dateFormatter.string(from: todayDate)
        
        if !(dateOfBirth < currentDateString || dateOfBirth == currentDateString) {
            errorValue.accept(errorMessage)
            print(errorMessage)
            print(dateOfBirth < currentDateString)
            print(dateOfBirth, currentDateString)
            return false
        } else {
            return true
        }
    }
    
    
}
