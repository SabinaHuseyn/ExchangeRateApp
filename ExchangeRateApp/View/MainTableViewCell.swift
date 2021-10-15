//
//  MainTableViewCell.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 14.10.21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    var btnCurrency: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .malina
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var exchLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .textBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let stackViewAll: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        
    }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setupStackView()
       }

    func setupStackView() {
        contentView.addSubview(stackViewAll)

        stackViewAll.addArrangedSubview(btnCurrency)
        stackViewAll.addArrangedSubview(exchLabel)
        
        NSLayoutConstraint.activate([
            stackViewAll.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
            stackViewAll.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            stackViewAll.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackViewAll.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0.0),
            stackViewAll.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0.0),
            stackViewAll.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0.0),
            stackViewAll.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0.0),
            ])

    }
    
}
