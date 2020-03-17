import RxSwift
import RxCocoa
import Foundation

struct PlaceFieldViewModel: FieldViewModel {
    var title: String = "Place Of Your Birth"
    
    var errorMessage: String = ""
    
    var value: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func validate() -> Bool {
        return true
    }
}
