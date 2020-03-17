import RxCocoa
import RxSwift

import Foundation

struct NameFieldViewModel: FieldViewModel {
    var title: String = "Full Name"
    
    var errorMessage: String = "Please add your Full Name"
    
    var value: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func validate() -> Bool {
        if value.value == "" {
            errorValue.accept(errorMessage)
        }
        
        return value.value != ""
    }
    
    
}
