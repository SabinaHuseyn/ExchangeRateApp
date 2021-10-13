//
//  MainTableViewCell.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 14.10.21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    let btnCurrency: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .malina
//        button.setTitle(name, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let badgeCount: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .textBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLabelandButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupLabelandButton() {
        
    }

}
