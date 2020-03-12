//
//  HoroscopeDetailsStack.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/12/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//
import RxSwift
import UIKit

class HoroscopeDetailsStack: UIStackView {
    let vm = HoroscopeViewModel.shared()
    let disposeBag = DisposeBag()
    
    let overalDetails: HoroscopeDetails = {
        let overalDetails = HoroscopeDetails()
        return overalDetails
    }()
    
    let loveDetails: HoroscopeDetails = {
        let loveDetails = HoroscopeDetails()
        loveDetails.horoscopeTitle = HoroscopeDataTypes.love.getTypeTitle(signName: nil)
        return loveDetails
    }()
    
    let healthDetails: HoroscopeDetails = {
        let healthDetails = HoroscopeDetails()
        healthDetails.horoscopeTitle = HoroscopeDataTypes.health.getTypeTitle(signName: nil)
        return healthDetails
    }()
    
    let careerDetails: HoroscopeDetails = {
        let careerDetails = HoroscopeDetails()
        careerDetails.horoscopeTitle = HoroscopeDataTypes.career.getTypeTitle(signName: nil)

        return careerDetails
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        axis = .vertical
        alignment = .fill
        spacing = 15
        distribution = .equalSpacing

        addArrangedSubview(overalDetails)
        addArrangedSubview(loveDetails)
        addArrangedSubview(healthDetails)
        addArrangedSubview(careerDetails)

        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        addBackground(color: Colors.COLOR_BACKGROUND_DARK_BLUE)
        
        vm.selectedSignSubject.subscribe(onNext: { [weak self] sign in
            self?.overalDetails.horoscopeTitle = HoroscopeDataTypes.overall.getTypeTitle(signName: sign.displayName)
        }).disposed(by: disposeBag)
        
        vm.horoscopeSelectedPeriodData.subscribe(onNext: { [weak self] periodData in
            self?.overalDetails.horoscopeDescription = periodData.overall_desc.isEmpty ? "Sorry, no data available" : periodData.overall_desc
            self?.loveDetails.horoscopeDescription = periodData.love_desc.isEmpty ? "Sorry, no data available" : periodData.love_desc
            self?.healthDetails.horoscopeDescription = periodData.health_desc.isEmpty ? "Sorry, no data available" : periodData.love_desc
            self?.careerDetails.horoscopeDescription = periodData.career_desc.isEmpty ? "Sorry, no data available" : periodData.career_desc
        }).disposed(by: disposeBag)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.layer.cornerRadius = 8
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
