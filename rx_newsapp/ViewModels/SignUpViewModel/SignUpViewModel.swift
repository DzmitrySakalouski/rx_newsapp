import RxSwift
import RxCocoa
import UIKit
import Foundation

class SignUpViewModel {
    private static var instance: SignUpViewModel!
    
    let userViewModel = UserViewModel.shared()
    
    let nameFieldViewModel = NameFieldViewModel()
    let dateFieldViewModel = DateFieldViewModel()
    let timeFieldViewModel = TimeFieldViewModel()
    let placeFieldViewModel = PlaceFieldViewModel()
    let emailFieldViewModel = EmailViewModel()
    
    private let disposeBag = DisposeBag()
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isSuccess = BehaviorRelay<Bool>(value: false)
    var errorMessage = BehaviorRelay<String?>(value: nil)
    
    func validateForm() -> Bool {
        return nameFieldViewModel.validate() && dateFieldViewModel.validate()
    }
    
    static func shared() -> SignUpViewModel {
        if instance == nil {
            instance = SignUpViewModel()
        }
        
        return instance!
    }
    
    func signUp() {
        
        let userPayload = UserData(
            name: nameFieldViewModel.value.value ?? "",
            birthday: dateFieldViewModel.value.value ?? "",
            email: emailFieldViewModel.value.value ?? "",
            timeOfBirth: timeFieldViewModel.value.value ?? "",
            placeOfBirth: placeFieldViewModel.value.value ?? ""
        )
        
        let resource = Resource<UserData>(url: URL(string: "https://horoplus.pro/api/user/")!, method: "POST", data: userPayload)
        
        self.isLoading.accept(true)

           URLRequest.post(resource: resource)
             .observeOn(MainScheduler.instance)
             .subscribe { response in
                guard let data = response.event.element else { return }
                let result = try? JSONDecoder().decode(SignUpResponce.self, from: data)
                if let isSuccess = result?.success {
                    self.isSuccess.accept(isSuccess)
                    self.userViewModel.currentUserRelay.accept(userPayload)
                    
                    self.nameFieldViewModel.value.accept(userPayload.name)
                    self.dateFieldViewModel.value.accept(userPayload.birthday)
                    self.timeFieldViewModel.value.accept(userPayload.timeOfBirth)
                    self.placeFieldViewModel.value.accept(userPayload.placeOfBirth)
                    self.emailFieldViewModel.value.accept(userPayload.email)
                }
            }.disposed(by: disposeBag)
    }

}

struct SignUpResponce: Decodable {
    let success: Bool
}

