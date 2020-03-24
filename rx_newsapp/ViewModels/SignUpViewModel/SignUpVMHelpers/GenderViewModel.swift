import RxSwift
import RxCocoa
import Foundation

struct GenderFieldViewModel {
    var value: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    func validate() -> Bool {
        return true
    }
}
