
import UIKit

class CompatibilityViewController: UIViewController {
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Two Zodiac Signs To Check The Compatibility"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = Colors.COLOR_WHITE
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.titleView = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        configureView()
    }
    
    private func configureView() {
        view.addSubview(headerLabel)
        headerLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        headerLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
    }
    

}
