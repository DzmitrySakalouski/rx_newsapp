import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    let menuItems = ["Notification", "Terms of Use", "Privacy Policy", "Contact Us"]
    
    let userVM = UserViewModel.shared()
    let disposeBag = DisposeBag()
    
    let reuseId = "MenuItem"
    
    lazy var userHeader: UIView = {
        let header = UIView()
        header.layer.cornerRadius = 8
        header.backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        header.addSubview(userHeaderStack)
        userHeaderStack.anchor(left: header.leftAnchor, paddingLeft: 30)
        userHeaderStack.centerYAnchor.constraint(equalToSystemSpacingBelow: header.centerYAnchor, multiplier: 0).isActive = true
        
        header.addSubview(editIcon)
        editIcon.anchor(right: header.rightAnchor, paddingRight: 30, width: 7, height: 13)
        editIcon.centerYAnchor.constraint(equalToSystemSpacingBelow: header.centerYAnchor, multiplier: 0).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleNavigateToEditProfile))
        header.addGestureRecognizer(tap)
        return header
    }()
    
    lazy var userHeaderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, signLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dzmitry Sakalouski"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = Colors.COLOR_WHITE
        return label
    }()
    
    var signLabel: UILabel = {
        let label = UILabel()
        label.text = "Gemini"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.COLOR_SECONDARY_TEXT
        return label
    }()
    
    var editIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow_card")
        iv.transform.rotated(by: 180)
        return iv
    }()
    
    var menuTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        configureSubscribtions()
    }

    private func configureView() {
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        menuTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 50, height: 176))
        menuTableView.register(ListBarTableViewCell.self, forCellReuseIdentifier: reuseId)
        menuTableView.isScrollEnabled = false
        menuTableView.backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        menuTableView.dividerColor = .clear
        menuTableView.separatorColor = Colors.COLOR_WHITE
        
        view.addSubview(userHeader)
        userHeader.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 15, paddingRight: 15, height: 113)
        
        let viewContainer = UIView()
        viewContainer.addSubview(menuTableView)
        view.addSubview(viewContainer)
        viewContainer.anchor(top: userHeader.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        viewContainer.layer.cornerRadius = 8
        viewContainer.backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        
        menuTableView.anchor(top: viewContainer.topAnchor, left: viewContainer.leftAnchor, bottom: viewContainer.bottomAnchor, right: viewContainer.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, height: 215)
    }
    
    @objc func handleNavigateToEditProfile() {
        let editVC = EditProfileViewController()
        tabBarController?.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func configureSubscribtions() {
        userVM.currentUserRelay.subscribe(onNext: { [weak self] user in
            guard let user = user else { return }
            self?.nameLabel.text = user.name
            let userZodiacSign = SignHelper.getSignFromDateRange(dateString: user.birthday)
            
            if userZodiacSign != nil {
                self?.signLabel.text = userZodiacSign?.displayName
            }
        }).disposed(by: disposeBag)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ListBarTableViewCell
        cell.itemText = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let notificationVC = NotificationViewController()
            tabBarController?.navigationController?.pushViewController(notificationVC, animated: true)
        default: print(indexPath.row)
        }
    }
}

