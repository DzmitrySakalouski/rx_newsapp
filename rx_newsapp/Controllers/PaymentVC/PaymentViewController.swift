//
//  PaymentViewController.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/16/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    lazy var logo: UIView = {
        let v = UIView()
        
        let iv = UIImageView()
        iv.anchor(width: 185, height: 185)
        iv.image = UIImage(named: "logo")
        v.addSubview(iv)
        v.translatesAutoresizingMaskIntoConstraints = false
        iv.centerXAnchor.constraint(equalToSystemSpacingAfter: v.centerXAnchor, multiplier: 0).isActive = true
        v.anchor(height: 185)
        return v
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Much More Then Just a Daily Horoscope"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = Colors.COLOR_WHITE
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy var featuresStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var startTrialButton: WhiteButton = {
        let btn = WhiteButton()
        btn.setTitle("Start 7-day Free Trial", for: .normal)
        return btn
    }()
    
    var paymentDeatilsLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.COLOR_SECONDARY_TEXT
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "$4.99/month after"
        return label
    }()
    
    lazy var logoContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 30
        container.addArrangedSubview(logo)
        container.addArrangedSubview(titleLabel)
        return container
    }()
    
    lazy var skipButton: UIBarButtonItem = {
        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(handleSkipOrder))
        return skipButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.COLOR_DARK_BLUE
        configureView()
        configureNavBar()
    }
    
    private func configureView() {
        view.addSubview(logoContainer)
        logoContainer.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
        logoContainer.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        
        view.addSubview(featuresStack)
        featuresStack.anchor(top: logoContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 35, paddingLeft: 20, paddingRight: 20)
        populateFeaturesList()
        
        view.addSubview(paymentDeatilsLabel)
        paymentDeatilsLabel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 32, height: 30)
        
        view.addSubview(startTrialButton)
        startTrialButton.anchor(left: view.leftAnchor ,bottom: paymentDeatilsLabel.topAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, height: 44)
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = Colors.COLOR_WHITE
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = skipButton
    }
    
    private func populateFeaturesList() {
        let features = [
            "Detailed future prediction for tomorrow, this week and the whole year",
            "Check Zodiac Compatibility with person you're interested in",
            "Get known how compatible you are with your friends"
        ]

        for feature in features {

            let featureLabel = UILabel()
            featureLabel.textColor = Colors.COLOR_SECONDARY_TEXT
            featureLabel.text = feature
            featureLabel.numberOfLines = 0
            featureLabel.font = UIFont.systemFont(ofSize: 15)
            
            let point = UILabel()
            point.text = "\u{2022}"
            point.textColor = Colors.COLOR_WHITE
            
            let pointContainer = UIView()
            pointContainer.addSubview(point)
            point.anchor(top: pointContainer.topAnchor, left: pointContainer.leftAnchor)
            pointContainer.anchor(width: 20)

            let listItem = UIStackView(arrangedSubviews: [pointContainer, featureLabel])
            listItem.axis = .horizontal
            listItem.spacing = 0
            featuresStack.addArrangedSubview(listItem)
        }
    }
    
    @objc func handleSkipOrder() {
        let mainHomeVC = MainHomeViewController()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = UINavigationController(rootViewController: mainHomeVC)
    }

}
