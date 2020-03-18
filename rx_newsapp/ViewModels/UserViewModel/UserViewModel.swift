import RxSwift
import RxCocoa
import Foundation

class UserViewModel {
    private static var instance: UserViewModel?
    
    let currentUserRelay = BehaviorRelay<UserData?>(value: nil)

    static func shared() -> UserViewModel {
        if instance == nil {
            instance = UserViewModel()
        }
        
        return instance!
    }
}
