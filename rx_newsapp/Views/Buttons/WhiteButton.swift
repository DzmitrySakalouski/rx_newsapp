import RxCocoa
import RxSwift
import UIKit

class WhiteButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(Colors.COLOR_DARK_BLUE, for: .normal)
        backgroundColor = Colors.COLOR_SECONDARY_TEXT
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        backgroundColor = Colors.COLOR_WHITE // TODO refactor
    }
    
    func update(signs: [ZodiacSign]) {
        if signs.count == 2 {
            backgroundColor = Colors.COLOR_WHITE
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: WhiteButton {
    var signsForCompatibility: Binder<[ZodiacSign]> {
        return Binder(self.base) {
            view, signsForCompatibility in
            view.update(signs: signsForCompatibility)
        }
    }
}
