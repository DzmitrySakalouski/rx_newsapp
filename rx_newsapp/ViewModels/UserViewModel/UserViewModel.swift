import RxSwift
import RxCocoa
import Foundation

class UserViewModel {
    private static var instance: UserViewModel?
    
    let currentUserRelay = BehaviorRelay<UserData?>(value: nil)
    
    let nameValue = BehaviorRelay<String>(value: "")
    let birthdayValue = BehaviorRelay<String>(value: "")
    let timeOfBirthValue = BehaviorRelay<String>(value: "")
    let placeOfBirthValue = BehaviorRelay<String>(value: "")
    let emailValue = BehaviorRelay<String>(value: "")
    
    let notificationTime = BehaviorRelay<String?>(value: nil)
    
    let notificationEnabled = BehaviorSubject<Bool>(value: false)

    static func shared() -> UserViewModel {
        if instance == nil {
            instance = UserViewModel()
        }
        
        return instance!
    }
}
