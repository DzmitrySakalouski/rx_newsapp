
import UIKit

class ZodiacViewCell: UICollectionViewCell {
    private var nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Colors.COLOR_WHITE
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "hello"
        return label
    }()
    
    private var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.textColor = Colors.COLOR_SECONDARY_TEXT
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private var signImage: UIImageView = {
        let signImage = UIImageView()
        return signImage
    }()
    
    private lazy var imageContainer: UIView = {
        let ic = UIView()
        ic.backgroundColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
        ic.layer.cornerRadius = 25
        ic.addSubview(self.signImage)
        ic.anchor(width: 50, height: 50)
        self.signImage.anchor(width: 30, height: 30)
        signImage.centerXAnchor.constraint(equalToSystemSpacingAfter: ic.centerXAnchor, multiplier: 0).isActive = true
        signImage.centerYAnchor.constraint(equalToSystemSpacingBelow: ic.centerYAnchor, multiplier: 0).isActive = true
        return ic
    }()
    
    private var signSelectStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.COLOR_DARK_BLUE
        
        signSelectStack.addArrangedSubview(imageContainer)
        signSelectStack.addArrangedSubview(nameLabel)
        signSelectStack.addArrangedSubview(periodLabel)
        addSubview(signSelectStack)
        
        signSelectStack.translatesAutoresizingMaskIntoConstraints = false
        signSelectStack.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        signSelectStack.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
    }
    
    func bind(sign: ZodiacSign) {
        self.nameLabel.text = sign.displayName
        self.periodLabel.text = sign.dateRangeShort
        self.signImage.image = UIImage(named: sign.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
