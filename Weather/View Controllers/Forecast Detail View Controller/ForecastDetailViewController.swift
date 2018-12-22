//
//  ForecastDetailViewController.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit

class ForecastDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ForecastViewModel?
    
    @IBOutlet weak var datePickerTextField: UITextField!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.reloadData()
        showDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Date().addDay(day: 4)
        
        //Toolbar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        datePickerTextField.inputAccessoryView = toolbar
        datePickerTextField.inputView = datePicker
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        datePickerTextField.text = formatter.string(from:  Date())
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        datePickerTextField.text = formatter.string(from: datePicker.date)
        
        viewModel?.date = datePicker.date
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

extension ForecastDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfForecast
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ForecastTableViewCell else { fatalError("TableView Error") }
        
        if let forecastProtocol = viewModel?.viewModel(for: indexPath.row) {
            cell.setProperties(withViewModel: forecastProtocol)
        }
        
        return cell
    }
}
