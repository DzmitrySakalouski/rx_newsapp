import Material
import UIKit

class TextInputView: TextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = Colors.COLOR_WHITE
        textColor = Colors.COLOR_WHITE
        placeholderLabel.textColor = Colors.COLOR_WHITE
        dividerActiveColor = Colors.COLOR_WHITE
        placeholderActiveColor = Colors.COLOR_WHITE
        placeholderNormalColor = Colors.COLOR_WHITE
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
