//
//  ViewController.swift
//  ExchangeRateApp
//
//  Created by Sabina Huseynova on 13.10.21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var mainTableView: UITableView!
    var rates: [String:Float] = [:]
    var ratesDictionary: NSDictionary = [:]
    let datePicker = UIDatePicker()
    var timeStamp: Int32?
    let persistenceManager = PersistenceManager.shared

    var titleLbl: UILabel = {
        var label = UILabel()
        label.text = "Exchange Rates"
        label.textAlignment = .center
        label.textColor = .malina
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getSavedTime()
        timeInterval()
        setupMainTableView()
        setupDatePickerView()
        setupLabel()
        self.mainTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
       DispatchQueue.main.async {
            self.mainTableView.reloadData()

        }
    }
    
    func timeInterval() {
        let currentTime = NSDate().timeIntervalSince1970
        
        if self.timeStamp != nil {
            guard let savedTime = self.timeStamp else { return }
            if ((Int(currentTime)) - (Int(savedTime))) > 600 {
                fetchData()
            } else {
                getSavedRates()
            }
        } else {
            fetchData()
        }
        
    }
// MARK: - Fetching Data
    func fetchData() {
        Service.shared.fetchRates() { rate  in
            self.saveRatesToCoreData(rate)
            let currentTime = NSDate().timeIntervalSince1970
            self.saveTimeToCoreData(Int(currentTime))
            DispatchQueue.main.async {
                self.rates = rate
                print("ETO RATE\(self.rates)")
                self.mainTableView.reloadData()
            }
        }
    }
    // MARK: - Setup Func
    func setupLabel() {
        self.view.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: mainTableView.topAnchor, constant: 0).isActive = true
    }
    
    func setupMainTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + 200
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        mainTableView = UITableView(frame: CGRect(x: 20, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        self.view.addSubview(mainTableView)
        self.view.addSubview(datePicker)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        self.mainTableView.tableFooterView = UIView()
        mainTableView.separatorColor = .textBlue
        mainTableView.tintColor = .textBlue
        mainTableView.estimatedRowHeight = 200
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    func setupDatePickerView(){
        self.view.addSubview(datePicker)
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.month = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.month = -400
        let minDate = calendar.date(byAdding: comps, to: Date())
        datePicker.datePickerMode = .date
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
        datePicker.backgroundColor = .backGrey
        datePicker.tintColor = .textBlue
        datePicker.inputViewController?.title = "Pick a date"
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.bottomAnchor.constraint(equalTo: mainTableView.topAnchor, constant: -20).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }
    // MARK: - DatePicker

    @objc func dateChanged(_ sender: UIDatePicker) {

            let iso8601DateFormatter = ISO8601DateFormatter()
            iso8601DateFormatter.formatOptions = [.withInternetDateTime]
            let string = iso8601DateFormatter.string(from: datePicker.date)

        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: sender.date)
            print(dateString)
            fetchDate(date: dateString)
    }
    
    func fetchDate(date:String) {
//        self.date = true
        Service.shared.fetchHistory(date: date,completion: {(list, err) in
            if let err = err {
                print("Failed to fetch news:", err)
                return
            }
            DispatchQueue.main.async {
                self.ratesDictionary = [:]
                self.rates.removeAll()
                self.rates = list
                self.mainTableView.reloadData()
            }
        })
    }
}
// MARK: - TableView Delegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.rates == [:] {
           return ratesDictionary.count
        } else {
            return rates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        if self.rates == [:] {
            let arrayKeys = Array(ratesDictionary.allKeys)
            let arrayValues = Array(ratesDictionary.allValues)

            let indexKeys = arrayKeys[indexPath.row]
            let indexValues = arrayValues[indexPath.row]
            if let values = indexValues as? Float {
                let formatted = String(format: "%.2f", values as CVarArg)
                cell.exchLabel.text = formatted
            }
            cell.btnCurrency.setTitle(("EUR / \(indexKeys)"), for: .normal)
        } else {
            let arrayKeys = Array(rates.keys)
            let index = arrayKeys[indexPath.row]
            cell.btnCurrency.setTitle(("EUR / \(index)"), for: .normal)
            let formatted = String(format: "%.2f", rates[index]!)
            cell.exchLabel.text = formatted
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
