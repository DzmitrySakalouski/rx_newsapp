import UIKit
import RxSwift
import RxCocoa

class SelectSignForCompareView: UIView {
    private var compatibilityVM = CompatibilityViewModel.shared()
    private var disposeBag = DisposeBag()
    
    var signForCompatibilityButton: SelectSignButton = {
        let signForCompatibilityButton = SelectSignButton()
        signForCompatibilityButton.containerBackgroundColor = Colors.COLOR_WHITE
        return signForCompatibilityButton
    }()
    
    var signForCompatibilityCompareButton: SelectSignButton = {
        let signForCompatibilityCompareButton = SelectSignButton()
        
        signForCompatibilityCompareButton.containerBackgroundColor = Colors.COLOR_SECONDARY_TEXT
        return signForCompatibilityCompareButton
    }()
    
    var percentLabelView: PercentLabel = {
        let percentLabelView = PercentLabel()
        return percentLabelView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    func configureView() {
        addSubview(signForCompatibilityButton)
        signForCompatibilityButton.anchor(top: topAnchor, left: leftAnchor, width: 100, height: 100)
               
        addSubview(signForCompatibilityCompareButton)
        signForCompatibilityCompareButton.anchor(top: topAnchor, right: rightAnchor, width: 100, height: 100)
               
        addSubview(percentLabelView)
        percentLabelView.anchor(width: 60, height: 60)
        percentLabelView.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        percentLabelView.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
        
        signForCompatibilityCompareButton.labelText = "Second Sign"
        signForCompatibilityButton.labelText = "First Sign"
        percentLabelView.percentLabelText = "+"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with signs: [ZodiacSign]) {
        switch signs.count {
        case 0:
            self.configureView()
            self.signForCompatibilityCompareButton.labelContainerBackgroundColor = .clear
            self.signForCompatibilityButton.labelContainerBackgroundColor = .clear
        case 1:
            self.signForCompatibilityButton.labelText = signs[0].displayName
            self.signForCompatibilityCompareButton.containerBackgroundColor = Colors.COLOR_WHITE
            self.signForCompatibilityButton.labelContainerBackgroundColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
            self.signForCompatibilityButton.labelTextFont = UIFont.boldSystemFont(ofSize: 14)
        case 2:
            self.signForCompatibilityCompareButton.labelText = signs[1].displayName
            self.signForCompatibilityCompareButton.labelContainerBackgroundColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
            self.signForCompatibilityCompareButton.labelTextFont = UIFont.boldSystemFont(ofSize: 14)
        default: return
        }
    }
    
    func updatePercentLabel(data: SignForCompatibilityCompare) {
        self.percentLabelView.percentLabelText = "\(data.percent)%"
    }
    
}

extension Reactive where Base: SelectSignForCompareView {
    var signsForCompatibility: Binder<[ZodiacSign]> {
        return Binder(self.base) {
            view, signsForCompatibility in
            view.update(with: signsForCompatibility)
        }
    }
    
    var percentCompatibility: Binder<SignForCompatibilityCompare> {
        return Binder(self.base) {
            view, data in
            view.updatePercentLabel(data: data)
        }
    }
}


