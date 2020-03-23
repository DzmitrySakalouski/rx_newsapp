import IQKeyboardManagerSwift
import RxSwift
import RxCocoa
import UIKit

class NotificationViewController: UIViewController {
    let userVM = UserViewModel.shared()
    let disposeBag = DisposeBag()
    
    var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(
        title: "", style: .plain, target: nil, action: nil)
        return backButton
    }()
    
    var notificationBar: NotificationListBar = {
        let nf = NotificationListBar()
        return nf
    }()
    
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChange), for: .valueChanged)
        return timePicker
    }()
    
    lazy var timeField: TextInputView = {
        let timeField = TextInputView()
        timeField.placeholder = "Schedule Notification"
        timeField.inputView = timePicker
        
        return timeField
    }()
    
    lazy var timeFieldContainer: UIView = {
        let v = UIView()
        v.backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        v.layer.cornerRadius = 7
        v.alpha = 0
        
        v.addSubview(timeField)
        timeField.anchor(left: v.leftAnchor, right: v.rightAnchor, paddingLeft: 15, paddingRight: 15)
        timeField.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.shared.enable = true
        configureView()
        configureSubscription()
        configureNavBar()
    }
    
    func configureView() {
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        view.addSubview(notificationBar)
        notificationBar.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 15, paddingRight: 15, height: 55)
        
        view.addSubview(timeFieldContainer)
        timeFieldContainer.anchor(top: notificationBar.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15, height: 95)
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = Colors.COLOR_WHITE
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func configureSubscription() {
        (notificationBar.switchView.rx.isOn <-> userVM.notificationEnabled).disposed(by: disposeBag)
        timeField.rx.text.bind(to: userVM.notificationTime).disposed(by: disposeBag)
        
        userVM.notificationEnabled.subscribe(onNext: { [weak self] isVisible in
            if isVisible {
                UIView.animate(withDuration: 0.5) {
                    self?.timeFieldContainer.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self?.timeFieldContainer.alpha = 0
                }
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func timeChange() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeField.text = dateFormatter.string(from: timePicker.date)
    }

}

