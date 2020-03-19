//
//  ListBarTableViewCell.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/18/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class ListBarTableViewCell: UITableViewCell {
    var itemText: String! {
        didSet {
            contentLabel.text = itemText
        }
    }
    
    var editIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow_card")
        iv.transform.rotated(by: 180)
        return iv
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = Colors.COLOR_WHITE
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        
        selectionStyle = .none
        
        addSubview(contentLabel)
        contentLabel.anchor(left: leftAnchor, paddingLeft: 17)
        contentLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
        
        addSubview(editIcon)
        editIcon.anchor(right: rightAnchor, paddingRight: 15)
        editIcon.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
