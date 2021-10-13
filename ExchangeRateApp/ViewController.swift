//
//  ViewController.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 13.10.21.
//

import UIKit

class ViewController: UIViewController {

    var mainTableView: UITableView!

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainTableView()
        
    }

    func setupMainTableView() {

        self.view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        self.mainTableView.tableFooterView = UIView()

        mainTableView.separatorColor = .textBlue
        mainTableView.tintColor = .textBlue
        mainTableView.estimatedRowHeight = 100
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
//        mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 30).isActive = true
        mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        mainTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
