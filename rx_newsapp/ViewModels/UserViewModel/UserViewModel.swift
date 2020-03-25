import RxSwift
import RxCocoa
import Foundation

class UserViewModel {
    private static var instance: UserViewModel?
    let userDefaults = UserDefaults.standard
    
    let currentUserRelay = BehaviorRelay<UserData?>(value: nil)
    
    let nameValue = BehaviorRelay<String>(value: "")
    let birthdayValue = BehaviorRelay<String>(value: "")
    let timeOfBirthValue = BehaviorRelay<String>(value: "")
    let placeOfBirthValue = BehaviorRelay<String>(value: "")
    let emailValue = BehaviorRelay<String>(value: "")
    
    let notificationTime = BehaviorRelay<String?>(value: "")
    
    let notificationEnabled = BehaviorRelay<Bool>(value: false)

    static func shared() -> UserViewModel {
        if instance == nil {
            instance = UserViewModel()
        }
        
        return instance!
    }
    
    func getPersistedNotificationData() {
        let notificationEnabledValue = userDefaults.bool(forKey: "notificationEnabled")
        notificationEnabled.accept(notificationEnabledValue)
        
        guard let notificationTimeValue = userDefaults.string(forKey: "notificationTime") else { return }
        print("notificationTimeValue => ", notificationTimeValue)
        notificationTime.accept(notificationTimeValue)
    }
    
    func setPersistedNotificationData() {
        userDefaults.set(notificationEnabled.value, forKey: "notificationEnabled")
        if notificationTime.value != nil {
            userDefaults.set(notificationTime.value!, forKey: "notificationTime")
        }
        
        print("setPersistedNotificationData => ", notificationTime.value!)
    }
}
