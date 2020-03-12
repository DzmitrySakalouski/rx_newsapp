import UIKit

class HoroscopeDetails: UIStackView {
    var horoscopeTitle: String! {
        didSet {
            titleLabel.text = horoscopeTitle
        }
    }
    var horoscopeDescription: String! {
        didSet {
            descriptionLabel.text = horoscopeDescription
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.COLOR_WHITE
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Sorry, no data available"
        
        label.textColor = Colors.COLOR_SECONDARY_TEXT
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
        spacing = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
