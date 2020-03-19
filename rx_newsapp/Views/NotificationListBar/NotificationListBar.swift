
import UIKit
import RxSwift
import RxCocoa

class NotificationListBar: UIView {
    var label: UILabel = {
        let label = UILabel()
        label.text = "Push Notifications"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Colors.COLOR_WHITE
        return label
    }()
    
    var switchView: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
        sw.tintColor = Colors.COLOR_SECONDARY_TEXT
        return sw
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        layer.cornerRadius = 7
        
        addSubview(label)
        label.anchor(left: leftAnchor, paddingLeft: 15)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(switchView)
        switchView.anchor(right: rightAnchor, paddingRight: 15)
        switchView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func update(with fieldVisible: Bool) {
        switchView.isOn = fieldVisible
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Reactive where Base: NotificationListBar {
    var tomeFieldVisible: Binder<Bool> {
        return Binder(self.base) {
            view, fieldVisible in
            view.update(with: fieldVisible)
        }
    }
}
