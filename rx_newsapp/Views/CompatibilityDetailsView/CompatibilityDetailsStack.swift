//
//  HoroscopeDetailsStack.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/12/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//
import RxSwift
import UIKit

class CompatibilirtDetailsStack: UIStackView {
    let vm = CompatibilityViewModel.shared()
    let disposeBag = DisposeBag()
    
    let marriageDetails: CompatibilityDetails = {
        let marriageDetails = CompatibilityDetails()
        return marriageDetails
    }()

    let sexualDetails: CompatibilityDetails = {
        let sexualDetails = CompatibilityDetails()
        sexualDetails.compatibilityTitle = "Sexual & Intimacy Compatibility"
        return sexualDetails
    }()

    let successDetails: CompatibilityDetails = {
        let successDetails = CompatibilityDetails()
        successDetails.compatibilityTitle = "Shared Activities and Success"
        return successDetails
    }()

    let familyDetails: CompatibilityDetails = {
        let familyDetails = CompatibilityDetails()
        familyDetails.compatibilityTitle = "Wealth and Family Compatibility"
        return familyDetails
    }()
    
    let childrenDetails: CompatibilityDetails = {
        let childrenDetails = CompatibilityDetails()
        childrenDetails.compatibilityTitle = "Children"
        return childrenDetails
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        axis = .vertical
        alignment = .fill
        spacing = 15
        distribution = .equalSpacing

        addArrangedSubview(marriageDetails)
        addArrangedSubview(successDetails)
        addArrangedSubview(sexualDetails)
        addArrangedSubview(familyDetails)
        addArrangedSubview(childrenDetails)

        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        addBackground(color: Colors.COLOR_BACKGROUND_DARK_BLUE)
        
        vm.selectedSignsForComatibility.subscribe(onNext: { [weak self] data in
            if data.count == 2 {
                self?.marriageDetails.compatibilityTitle = "\(data[0].displayName) and \(data[1].displayName): Marriage Compatibility"
            }
        }).disposed(by: disposeBag)

        vm.selectedSignsCompatibilityData.subscribe(onNext: { [weak self] data in
            let localeData = data.details[0]
            self?.marriageDetails.compatibilityDescription = localeData.marriage
            self?.successDetails.compatibilityDescription = localeData.success
            self?.sexualDetails.compatibilityDescription = localeData.sexual
            self?.familyDetails.compatibilityDescription = localeData.wealth_and_family
            self?.childrenDetails.compatibilityDescription = localeData.children
        }).disposed(by: disposeBag)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

