import UserNotifications
import UIKit
import RxSwift

class HoroscopeViewController: UIViewController {
    let disposeBag = DisposeBag()
    var horoscopeVM: HoroscopeViewModel!
    
    // MARK: - Viewvs
    lazy var dropdownLabel: UILabel = {
        let button = UILabel()
        button.text = "Press"
        button.textAlignment = .center
        button.textColor = Colors.COLOR_WHITE
        button.font = UIFont.systemFont(ofSize: 17)
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(handleTogglePopupOpen))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(labelTap)
        return button
    }()
    
    private var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.anchor(height: 45)
        button.setTitleColor(Colors.COLOR_DARK_BLUE, for: .normal)
        button.backgroundColor = Colors.COLOR_WHITE
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var popupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        
        return view
    }()
    
    private var visualEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var signCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = Colors.COLOR_DARK_BLUE
        cv.layer.cornerRadius = 5
        cv.register(ZodiacViewCell.self, forCellWithReuseIdentifier: "ZodiacCell")
        return cv
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(Colors.COLOR_WHITE, for: .normal)
        btn.setTitle("Close", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleTogglePopupClose), for: .touchUpInside)
        return btn
    }()
    
    private var horoscopeDetailsStack: HoroscopeDetailsStack = {
        let hd = HoroscopeDetailsStack()
        hd.backgroundColor = .red
        return hd
    }()
    
    private let periodSelectionControl: SegmentedControl = {
        let sg = SegmentedControl()
        sg.anchor(paddingTop: 10)
        sg.setButtonTitles(buttonTitles: [Periods.yesterday.rawValue, Periods.today.rawValue, Periods.tomorrow.rawValue, Periods.thisWeek.rawValue, Periods.year.rawValue])
        return sg
    }()
    
    let horoscopeStats: HoroscopeStatsView = {
        let stats = HoroscopeStatsView()
        stats.viewModel = HoroscopeViewModel.shared()
        return stats
    }()
    
    let horoscopeDataScrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.backgroundColor = Colors.COLOR_DARK_BLUE
        return sc
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.isHidden = true
        return ai
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.navigationBar.isHidden = false
        tabBarController?.navigationItem.titleView = dropdownLabel
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yea")
                print("Yea")
                print("Yea")
                print("Yea")
                print("Yea")
                print("Yea")
                print("Yea")
            } else {
                print("No")
            }
        }

                
        horoscopeVM = HoroscopeViewModel.shared()
        horoscopeVM.getHoroscopeData()
                
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        dropdownLabel.translatesAutoresizingMaskIntoConstraints = false
        dropdownLabel.textAlignment = .center
        tabBarController?.navigationItem.titleView = dropdownLabel
        
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
                
        NSLayoutConstraint.activate([
            dropdownLabel.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor, constant: 10),
            dropdownLabel.trailingAnchor.constraint(equalTo: navigationController!.navigationBar.trailingAnchor, constant: -10),
        ])

        signCollectionView.delegate = self
        signCollectionView.dataSource = self

        let zodiacDashBoardDetailsView = ZodiacDashboardDetailsView()
        configureSubscribtions()
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 0).isActive = true

        view.addSubview(horoscopeDataScrollView) // -----
        horoscopeDataScrollView.translatesAutoresizingMaskIntoConstraints = false
        horoscopeDataScrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            horoscopeDataScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horoscopeDataScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            horoscopeDataScrollView.topAnchor.constraint(equalTo: view.topAnchor), //(equalTo: dropdownLabel.bottomAnchor, ),
            horoscopeDataScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            horoscopeStats.heightAnchor.constraint(equalToConstant: 155)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(periodSelectionControl)
        stackView.spacing = 30
        stackView.addArrangedSubview(zodiacDashBoardDetailsView)
        stackView.addArrangedSubview(horoscopeStats)
        stackView.addArrangedSubview(horoscopeDetailsStack)
        stackView.addArrangedSubview(shareButton)
        
        horoscopeDataScrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: horoscopeDataScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: horoscopeDataScrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: horoscopeDataScrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: horoscopeDataScrollView.bottomAnchor, constant: -30),
            stackView.widthAnchor.constraint(equalTo: horoscopeDataScrollView.widthAnchor)
        ])

    }
    
    private func onShow() {
        view.addSubview(visualEffect)
        visualEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        visualEffect.alpha = 0
        
        view.addSubview(popupView)
        popupView.anchor(top: navigationController?.navigationBar.topAnchor, bottom: tabBarController?.tabBar.topAnchor, paddingTop: 10, paddingBottom: 10, width: view.frame.width - 20)
        popupView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        
        popupView.addSubview(closeButton)
        closeButton.anchor(left: popupView.leftAnchor, bottom: popupView.bottomAnchor, right: popupView.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        popupView.addSubview(signCollectionView)
        signCollectionView.anchor(top: popupView.topAnchor, left: popupView.leftAnchor, bottom: closeButton.topAnchor, right: popupView.rightAnchor)
        
        popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffect.alpha = 1
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
    
    private func onHide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popupView.alpha = 0
            self.visualEffect.alpha = 0
        }){ (_) in
            self.visualEffect.removeFromSuperview()
            self.popupView.removeFromSuperview()
        }
    }
    
    //MARK: - Handlers
    @objc private func handleTogglePopupOpen() {
         self.horoscopeVM.isPopupOpenSubject.accept(true)
    }
    
    @objc private func handleTogglePopupClose() {
         self.horoscopeVM.isPopupOpenSubject.accept(false)
    }
    
    //MARK: - Rx Subscriptions
    private func configureSubscribtions() {
        
        self.horoscopeVM.isPopupOpenSubject.subscribe(onNext: {
            if $0 { self.onShow() }
            else { self.onHide() }
        }).disposed(by: disposeBag)
        
        let selectedSign = self.horoscopeVM.selectedSignSubject.asDriver(onErrorJustReturn: zodiacSignsArray[0])
        selectedSign.map{ "\($0.displayName)"}.drive(self.dropdownLabel.rx.text).disposed(by: disposeBag)
        
        self.horoscopeVM.showLoading.subscribe( onNext: { [weak self] showLoading in
            self?.activityIndicator.isHidden = !showLoading
            self?.horoscopeDataScrollView.isHidden = showLoading
        }).disposed(by: disposeBag)
    }
}

