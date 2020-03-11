import UIKit
import Foundation

class SegmentedControl: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    
    let vm = HoroscopeViewModel.shared()
    var selectedIndex: Int!
    var textColor: UIColor = Colors.COLOR_SECONDARY_TEXT
    var itemBackgroundColor: UIColor = Colors.COLOR_BACKGROUND_DARK_BLUE
    var selectorTextColor: UIColor = Colors.COLOR_WHITE
    var selectedBackgroundColor: UIColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectedIndex = vm.selectedPeriodIdSubject.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach{ $0.removeFromSuperview() }
        guard let titles = self.buttonTitles else {
            return
        }
        for buttonTitle in titles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.backgroundColor = itemBackgroundColor
            button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.layer.cornerRadius = 5
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            buttons.append(button)
        }
    }
    
    @objc func actionButton(sender: UIButton) {
        for (btnId, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            btn.backgroundColor = itemBackgroundColor
            if btn == sender {
                vm.getHoroscopePeriodData(by: btnId)
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.backgroundColor = selectedBackgroundColor
            }
            
        }

    }
    
    private func updateView() {
        createButton()
        configureStackView()
        
        for (btnId, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            btn.backgroundColor = itemBackgroundColor
            if btnId == selectedIndex {
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.backgroundColor = selectedBackgroundColor
            }
            
        }
    }
}
