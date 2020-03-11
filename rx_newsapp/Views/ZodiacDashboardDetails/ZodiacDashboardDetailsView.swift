import UIKit
import Foundation
import RxCocoa
import RxSwift

class ZodiacDashboardDetailsView: UIView {
    var horoscopeViewModel: HoroscopeViewModel!
    let disposedBag = DisposeBag()
    
    var sign: ZodiacSign? {
        didSet {
            guard let sign = sign else { return }
            self.imageView.image = UIImage(named: sign.image)
            self.nameLabel.text = sign.displayName
            self.dateRangeLabel.text = sign.dateRange
        }
    }
    
    // MARK: - views
    var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.COLOR_WHITE
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    lazy var imageContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 124 / 2
        v.backgroundColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
        return v
    }()
    
    var dateRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = Colors.COLOR_SECONDARY_TEXT
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        horoscopeViewModel = HoroscopeViewModel.shared()
        
        addSubview(imageContainer)
        imageContainer.anchor(top: topAnchor, left: leftAnchor, width: 124, height: 124)
        imageContainer.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        imageContainer.addSubview(imageView)
        imageView.anchor(width: 80, height: 80)
        imageView.centerYAnchor.constraint(equalToSystemSpacingBelow: imageContainer.centerYAnchor, multiplier: 0).isActive = true
        imageView.centerXAnchor.constraint(equalToSystemSpacingAfter: imageContainer.centerXAnchor, multiplier: 0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, dateRangeLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        addSubview(stackView)
        stackView.anchor(left: imageContainer.rightAnchor, paddingLeft: 20)
        stackView.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        
        let selectedSign = self.horoscopeViewModel.selectedSignSubject.asDriver(onErrorJustReturn: zodiacSignsArray[0])
        selectedSign.map{ "\($0.displayName)"}.drive(self.nameLabel.rx.text).disposed(by: disposedBag)
        selectedSign.map{ "\($0.dateRange)"}.drive(self.dateRangeLabel.rx.text).disposed(by: disposedBag)
        selectedSign.map{ UIImage(named: $0.image) }.drive(self.imageView.rx.image).disposed(by: disposedBag)
    }
    
    private func configureView() {
        addSubview(imageContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
