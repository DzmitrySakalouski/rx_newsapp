
import UIKit
import RxSwift

class CompatibilityViewController: UIViewController {
    var compatibilityVM = CompatibilityViewModel.shared()
    var disposeBag = DisposeBag()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Two Zodiac Signs To Check The Compatibility"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = Colors.COLOR_WHITE
        return label
    }()
    
    private var compatibilityDetailsStack: CompatibilirtDetailsStack = {
        let cd = CompatibilirtDetailsStack()
        cd.backgroundColor = .red
        return cd
    }()
    
    private var compatibilityScrollView: UIScrollView = {
        let compatibilityScrollView = UIScrollView()
        compatibilityScrollView.showsVerticalScrollIndicator = false
        return compatibilityScrollView
    }()
    
    private let selectSignView: SelectSignForCompareView = {
        let selectView = SelectSignForCompareView()
        return selectView
    }()
    
    private lazy var checkCompatibilityButton: WhiteButton = {
        let btn = WhiteButton()
        btn.setTitle("Check Compatibility", for: .normal)
        btn.addTarget(self, action: #selector(handleCheckCompabilityPress), for: .touchUpInside)
        btn.isEnabled = false
        return btn
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
    
    let compatibilityStats: HoroscopeStatsView = {
        let stats = HoroscopeStatsView()
        stats.viewModelCompatibility = CompatibilityViewModel.shared()
        return stats
    }()
    
    lazy var clearButton: UIBarButtonItem = {
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(handleClearData))
        clearButton.tintColor = Colors.COLOR_WHITE
        return clearButton
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    // MARK: - lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.titleView = nil
        compatibilityVM.selectedSignsForComatibility.accept([ZodiacSign]())
        selectSignView.removeFromSuperview()
        stackView.removeFromSuperview()
        configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signCollectionView.delegate = self
        signCollectionView.dataSource = self
        
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        configureView()
    }
    
    // MARK: - handlers
    private func configureView() {
        configureBasicView()
        renderSignSelectView()
        configureSubscribtions()
    }
    
    private func configureBasicView() {
        view.addSubview(compatibilityScrollView)
        compatibilityScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            compatibilityScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            compatibilityScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            compatibilityScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            compatibilityScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        compatibilityScrollView.addSubview(headerLabel)
        headerLabel.anchor(top: compatibilityScrollView.topAnchor, left: compatibilityScrollView.leftAnchor, right: compatibilityScrollView.rightAnchor)
        headerLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: compatibilityScrollView.centerXAnchor, multiplier: 0).isActive = true
        
        compatibilityScrollView.addSubview(selectSignView)
        selectSignView.anchor(top: headerLabel.bottomAnchor, paddingTop: 27, width: 230, height: 100)
        selectSignView.centerXAnchor.constraint(equalToSystemSpacingAfter: compatibilityScrollView.centerXAnchor, multiplier: 0).isActive = true
        
        compatibilityScrollView.addSubview(checkCompatibilityButton)
        checkCompatibilityButton.isEnabled = false
        checkCompatibilityButton.anchor(top: selectSignView.bottomAnchor, left: compatibilityScrollView.leftAnchor, right: compatibilityScrollView.rightAnchor, paddingTop: 30, height: 44)
    }
    
    private func renderSignSelectView() {
        view.addSubview(signCollectionView)
        signCollectionView.isScrollEnabled = true
        signCollectionView.contentSize.height = 600
        signCollectionView.anchor(top: checkCompatibilityButton.bottomAnchor, left: compatibilityScrollView.leftAnchor, bottom: view.bottomAnchor, right: compatibilityScrollView.rightAnchor, paddingTop: 10)
        
    }
    
    func configureSubscribtions() {
        let selectedSignsForComatibilityDriver = compatibilityVM.selectedSignsForComatibility.asDriver()
        selectedSignsForComatibilityDriver.drive(selectSignView.rx.signsForCompatibility).disposed(by: disposeBag)
        selectedSignsForComatibilityDriver.drive(checkCompatibilityButton.rx.signsForCompatibility).disposed(by: disposeBag)
        
        self.compatibilityVM.selectedSignsForComatibility.subscribe(onNext: { [weak self] selectedSigns in
                self?.checkCompatibilityButton.isEnabled = selectedSigns.count == 2
            }).disposed(by: disposeBag)
    }
    
    @objc func handleCheckCompabilityPress() {
        signCollectionView.removeFromSuperview()
        headerLabel.removeFromSuperview()
        checkCompatibilityButton.removeFromSuperview()
        selectSignView.removeFromSuperview()
        
        tabBarController?.navigationItem.rightBarButtonItem = clearButton
        
        compatibilityScrollView.addSubview(selectSignView)
        selectSignView.anchor(top: compatibilityScrollView.topAnchor, width: 230, height: 100)
        selectSignView.centerXAnchor.constraint(equalToSystemSpacingAfter: compatibilityScrollView.centerXAnchor, multiplier: 0).isActive = true
        
        self.compatibilityVM.selectedSignsCompatibilityData.asDriver().drive(selectSignView.rx.percentCompatibility).disposed(by: disposeBag)
        
        compatibilityVM.getCompatibilitySignData()
    
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(compatibilityStats)
        stackView.addArrangedSubview(compatibilityDetailsStack)
        NSLayoutConstraint.activate([
            compatibilityStats.heightAnchor.constraint(equalToConstant: 155)
        ])
        compatibilityScrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: compatibilityScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: compatibilityScrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: selectSignView.bottomAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: compatibilityScrollView.bottomAnchor, constant: -30),
            stackView.widthAnchor.constraint(equalTo: compatibilityScrollView.widthAnchor)
        ])
        
    }
    
    @objc func handleClearData() {
        self.selectSignView.removeFromSuperview()
        self.stackView.removeFromSuperview()
        self.compatibilityScrollView.removeFromSuperview()
        tabBarController?.navigationItem.rightBarButtonItem = nil
        self.compatibilityVM.selectedSignsCompatibilityData.accept(SignForCompatibilityCompare.empty)
        self.compatibilityVM.selectedSignsForComatibility.accept([ZodiacSign]())
        self.configureView()
    }
    
}
