//
//  NewsViewCell.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/6/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor,paddingTop: 10, paddingLeft: 10, width: frame.width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(article: Article) {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
