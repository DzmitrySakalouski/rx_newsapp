import RxSwift
import RxCocoa
import Foundation

class SignUpViewModel {
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
        print(dateFieldViewModel.validate())
        return nameFieldViewModel.validate() && dateFieldViewModel.validate()
    }
    
    func signUp() {
        let userPayload = UserData(
            name: nameFieldViewModel.value.value,
            birthday: dateFieldViewModel.value.value,
            email: emailFieldViewModel.value.value,
            timeOfBirth: timeFieldViewModel.value.value,
            placeOfBirth: placeFieldViewModel.value.value
        )
        
        print(" Value: -> \(nameFieldViewModel.value.value)")
        
        
        let resource = Resource<UserData>(url: URL(string: "https://horoplus.pro/api/user/")!, method: "POST", data: userPayload)
        
        self.isLoading.accept(true)

           URLRequest.post(resource: resource)
             .observeOn(MainScheduler.instance)
             .subscribe { response in
                guard let data = response.event.element else { return }
                let result = try? JSONDecoder().decode(SignUpResponce.self, from: data)
                if let isSuccess = result?.success {
                    self.isSuccess.accept(isSuccess)
                }
            }.disposed(by: disposeBag)
    }

}

struct SignUpResponce: Decodable {
    let success: Bool
}

