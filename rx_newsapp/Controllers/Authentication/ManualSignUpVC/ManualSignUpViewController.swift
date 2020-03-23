import Material
import UIKit
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa

class ManualSignUpViewController: UIViewController, UITextFieldDelegate {
    var viewModel = SignUpViewModel.shared()
    var disposeBag = DisposeBag()
        
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Everyday Actual Horoscope About Your Zodiac Sign"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = Colors.COLOR_WHITE
        return label
    }()
    
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
    
    lazy var inputStack: UIStackView = {
        let inputStack = UIStackView(arrangedSubviews: [nameInput, dateField, timeField, placeField, emailField])
        inputStack.axis = .vertical
        inputStack.spacing = 25
        return inputStack
    }()
    
    lazy var submitButton: WhiteButton = {
        let btn = WhiteButton()
        btn.setTitle("Done", for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        dateField.delegate = self
        timeField.delegate = self
        placeField.delegate = self
        emailField.delegate = self
        
        IQKeyboardManager.shared.enable = true
        configureView()
        configureNavBar()
        configureBinding()
    }

    private func configureView() {
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 22, paddingRight: 22)
        
        view.addSubview(inputStack)
        inputStack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(submitButton)
        submitButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 30, paddingRight: 16, height: 44)
    }
    
    private func configureNavBar() {
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
    
    func configureBinding() {
        let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        nameInput.rx.text.orEmpty.bind(to: viewModel.nameFieldViewModel.value).disposed(by: disposeBag)
        dateField.rx.text.orEmpty.bind(to: viewModel.dateFieldViewModel.value).disposed(by: disposeBag)
        timeField.rx.text.orEmpty.bind(to: viewModel.timeFieldViewModel.value).disposed(by: disposeBag)
        placeField.rx.text.orEmpty.bind(to: viewModel.placeFieldViewModel.value).disposed(by: disposeBag)
        emailField.rx.text.orEmpty.bind(to: viewModel.emailFieldViewModel.value).disposed(by: disposeBag)
                
        submitButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                if self.viewModel.validateForm() {
                    self.viewModel.signUp()
                } else {
                    if !self.viewModel.emailFieldViewModel.validate() {
                        alert.message = "Wrong Email"
                    }
                    else if !self.viewModel.nameFieldViewModel.validate() {
                        alert.message = "Please fill your Name"
                    }
                    else if !self.viewModel.dateFieldViewModel.validate() {
                        alert.message = "Wrong Birthday date"
                    }
                    self.present(alert, animated: true)
                }
            }).disposed(by: disposeBag)
        
        viewModel.isSuccess.subscribe(onNext: { [unowned self] isSuccess in
            if isSuccess {
                let paymentVC = PaymentViewController()
                self.navigationController?.pushViewController(paymentVC, animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
