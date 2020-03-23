import RxCocoa
import RxSwift
import Foundation

protocol FieldViewModel {
    var title: String { get }
    var errorMessage: String { get }
    
    var value: BehaviorRelay<String?> { get set }
    var errorValue: BehaviorRelay<String?> { get set }
    
    func validate() -> Bool
}

extension FieldViewModel {
    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
