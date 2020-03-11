
import UIKit

class ZodiacViewCell: UICollectionViewCell {
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, paddingTop: 7)
        nameLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
    }
    
    func bind(sign: ZodiacSign) {
        self.nameLabel.text = sign.displayName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
