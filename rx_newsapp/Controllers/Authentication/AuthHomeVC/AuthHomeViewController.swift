import FacebookLogin
import FacebookCore
import UIKit

class AuthHomeViewController: UIViewController {
    var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "logo")
        iv.anchor(width: 205, height: 205)
        return iv
    }()
    
    lazy var logoContainer: UIStackView = {
        let container = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        container.axis = .vertical
        container.spacing = 54
        return container
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome To Horoscope Premium"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = Colors.COLOR_WHITE
        label.numberOfLines = 2
        return label
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        
        stack.addArrangedSubview(facebookLoginButton)
        stack.addArrangedSubview(manualSignUpButton)

        return stack
    }()
    
    var facebookLoginButton: WhiteButton = {
        let fbButton = WhiteButton()
        fbButton.anchor(height: 44)
        fbButton.setTitle("Sign Up with Facebook", for: .normal)
        fbButton.addTarget(self, action: #selector(loginWithReadPermissions), for: .touchUpInside)
        
        return fbButton
    }()
    
    var manualSignUpButton: OutlinedButton = {
        let manualSignUpButton = OutlinedButton()
        manualSignUpButton.anchor(height: 44)
        manualSignUpButton.setTitle("Sign Up Manually", for: .normal)
        manualSignUpButton.addTarget(self, action: #selector(loginManually), for: .touchUpInside)

        return manualSignUpButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        logOut()
        configureView()
        test()
    }
    
    func configureView() {
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        view.addSubview(logoContainer)
        logoContainer.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 76, paddingLeft: 80, paddingRight: 80)
        logoContainer.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        view.addSubview(buttonStack)
        buttonStack.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 32, paddingRight: 15)
    }
    
    func loginManagerDidComplete(_ result: LoginResult) {
        switch result {
        case .cancelled:
            print("======= cancelled =======")

        case .failed(let error):
            print("Failed \(error.localizedDescription)")

        case .success(_, _, _):
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, birthday"]).start(completionHandler: {
                (connection, result, error) -> Void in
                if (error == nil){
                    
                    if let resultData = result as? NSDictionary {
                        
                        let name  = resultData["name"] as? String
                        let birthday = resultData["birthday"] as? String
                        let currentUser = UserData(
                            name: name ?? "",
                            birthday: birthday ?? "",
                            email: "",
                            timeOfBirth: "",
                            placeOfBirth: ""
                        )
                        
                        let paymentVC = PaymentViewController()
                        self.navigationController?.pushViewController(paymentVC, animated: true)
                    }
                    
                }else{
                    print(error?.localizedDescription ?? "Not found")
                }
            })
        }
            
    }

    @objc private func loginWithReadPermissions() {
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [.publicProfile],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    @objc private func loginManually() {
        let manualSignUpVC = ManualSignUpViewController()
        navigationController?.pushViewController(manualSignUpVC, animated: true)
    }

    private func logOut() {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    
    func test() {
        
    }
}
