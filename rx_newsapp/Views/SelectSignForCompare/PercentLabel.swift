//
//  PercentLabel.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/13/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class PercentLabel: UIView {
    var percentLabelText: String! {
        didSet {
            percentLabel.text = percentLabelText
        }
    }
    
    var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = Colors.COLOR_WHITE
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE
        layer.borderColor = Colors.COLOR_BACKGROUND_MEDIUM_BLUE.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 30
        
        addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        percentLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
