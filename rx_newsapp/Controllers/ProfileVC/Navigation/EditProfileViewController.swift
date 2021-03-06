import IQKeyboardManagerSwift
import RxSwift
import RxCocoa
import UIKit

class EditProfileViewController: UIViewController {
    let userVM = UserViewModel.shared()
    let updateVM = SignUpViewModel.shared()
    
    let disposeBag = DisposeBag()
    
    var nameInput: TextInputView = {
        let nameInput = TextInputView()
        nameInput.placeholder = "Full Name"
        return nameInput
    }()
       
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        return datePicker
    }()
    
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChange), for: .valueChanged)
        return timePicker
    }()
    
    lazy var dateField: TextInputView = {
        let dateField = TextInputView()
        dateField.placeholder = "Date of your Birth"
        dateField.inputView = self.datePicker
        
        return dateField
    }()
    
    lazy var timeField: TextInputView = {
        let timeField = TextInputView()
        timeField.placeholder = "Time of your Birth"
        timeField.inputView = timePicker
    
        return timeField
    }()
    
    var placeField: TextInputView = {
        let placeField = TextInputView()
        placeField.placeholder = "Place of your Birth"
        return placeField
    }()
    
    var emailField: TextInputView = {
        let emailField = TextInputView()
        emailField.placeholder = "Your E-mail"
        return emailField
    }()
    
    var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        return backButton
    }()
    
    lazy var header: UIView = {
        let header = UIView()
        header.addSubview(nameLabel)
        nameLabel.anchor(top: header.topAnchor)
        nameLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: header.centerXAnchor, multiplier: 0).isActive = true
        
        header.addSubview(signLabel)
        signLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 10)
        signLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: header.centerXAnchor, multiplier: 0).isActive = true

        return header
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = Colors.COLOR_WHITE
        label.text = "Dzmitry Sakalousli"
        return label
    }()
    
    var signLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Colors.COLOR_SECONDARY_TEXT
        label.text = "Gemini"
        return label
    }()
    
    lazy var formStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameInput,
            dateField,
            timeField,
            placeField,
            emailField
        ])
        stack.axis = .vertical
        stack.spacing = 30
        
        stack.backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        
        return stack
    }()
    
    lazy var submitButton: WhiteButton = {
        let btn = WhiteButton()
        btn.setTitle("Save", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        configureNavBar()
        configureView()
    }

    func configureView() {
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        
        view.addSubview(header)
        header.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        view.addSubview(formStack)
        formStack.anchor(top: header.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 90, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(submitButton)
        submitButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, height: 44)
        
        configureSubscribtions()
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = Colors.COLOR_WHITE
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func dateChange() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateField.text = dateFormatter.string(from: datePicker.date)
        print(dateFormatter.string(from: datePicker.date))
    }
    
    @objc func onClickDoneButton() {
        view.endEditing(true)
    }
    
    @objc func timeChange() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeField.text = dateFormatter.string(from: timePicker.date)
        print(dateFormatter.string(from: datePicker.date))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
    
    func configureSubscribtions() {
        let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        userVM.currentUserRelay.subscribe(onNext: { [weak self] user in
            guard let user = user else { return }
            
            self?.nameLabel.text = user.name

            let userZodiacSign = SignHelper.getSignFromDateRange(dateString: user.birthday)
            if userZodiacSign != nil {
                self?.signLabel.text = userZodiacSign?.displayName
            }
        }).disposed(by: disposeBag)
        

        (nameInput.rx.text <-> updateVM.nameFieldViewModel.value).disposed(by: disposeBag)
        (dateField.rx.text <-> updateVM.dateFieldViewModel.value).disposed(by: disposeBag)
        (timeField.rx.text <-> updateVM.timeFieldViewModel.value).disposed(by: disposeBag)
        (placeField.rx.text <-> updateVM.placeFieldViewModel.value).disposed(by: disposeBag)
        (emailField.rx.text <-> updateVM.emailFieldViewModel.value).disposed(by: disposeBag)

        submitButton.rx.tap
        .subscribe(onNext: { [unowned self] in
            if self.updateVM.validateForm() {
                self.updateVM.signUp()
                self.goBack()
            } else {
                if !self.updateVM.emailFieldViewModel.validate() {
                    alert.message = "Wrong Email"
                }
                else if !self.updateVM.nameFieldViewModel.validate() {
                    alert.message = "Please fill your Name"
                }
                else if !self.updateVM.dateFieldViewModel.validate() {
                    alert.message = "Wrong Birthday date"
                }
                self.present(alert, animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
