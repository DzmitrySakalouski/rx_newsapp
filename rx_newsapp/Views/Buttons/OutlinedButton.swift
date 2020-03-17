//
//  OutlinedButton.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/15/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class OutlinedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = Colors.COLOR_WHITE.cgColor
        layer.borderWidth = 1.5
        setTitleColor(Colors.COLOR_WHITE, for: .normal)
        layer.cornerRadius = 6
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
