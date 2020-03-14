//
//  SelectSignButton.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/13/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class SelectSignButton: UIView {
    var labelText: String! {
        didSet {
            signForCompatibilityLabel.text = labelText
        }
    }
    
    var containerBackgroundColor: UIColor! {
        didSet {
            self.signForCompatibilityLabel.textColor = containerBackgroundColor
        }
    }
    
    var labelContainerBackgroundColor: UIColor! {
        didSet {
            self.labelContainer.backgroundColor = labelContainerBackgroundColor
        }
    }
    
    var labelTextFont: UIFont! {
        didSet {
            self.signForCompatibilityLabel.font = labelTextFont
        }
    }
    
    var borderView: UIView = {
        let borderView = UIView()
        borderView.layer.borderColor = Colors.COLOR_BACKGROUND_DARK_BLUE.cgColor
        borderView.layer.borderWidth = 2
        borderView.layer.cornerRadius = 42
        return borderView
    }()
    
    var labelContainer: UIView = {
        let labelContainer = UIView()
        labelContainer.layer.cornerRadius = 30
        return labelContainer
    }()
        
    var signForCompatibilityLabel: UILabel = {
        let sccLabel = UILabel()
        sccLabel.numberOfLines = 2
        sccLabel.font = UIFont.systemFont(ofSize: 14)
        sccLabel.textAlignment = .center
        sccLabel.text = "First Sign"
        return sccLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 50
        layer.borderColor = Colors.COLOR_BACKGROUND_DARK_BLUE.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 50
        addSubview(self.borderView)
        self.borderView.anchor(width: 84, height: 84)
        self.borderView.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
        self.borderView.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        
        addSubview(labelContainer)
        self.labelContainer.anchor(width: 60,height: 60)
        self.labelContainer.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
        self.labelContainer.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        
        self.labelContainer.addSubview(self.signForCompatibilityLabel)
        self.signForCompatibilityLabel.anchor(left: labelContainer.leftAnchor, right: labelContainer.rightAnchor)
        self.signForCompatibilityLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: labelContainer.centerXAnchor, multiplier: 0).isActive = true
        self.signForCompatibilityLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: labelContainer.centerYAnchor, multiplier: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
