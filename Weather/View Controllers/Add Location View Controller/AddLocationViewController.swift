//
//  AddLocationViewController.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var locations: [Location] = []
    private lazy var geocoder = CLGeocoder()
    
    var delegate: AddLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Helpers
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString else {
            locations = []
            
            tableView.reloadData()
            return
        }
        
        geocoder.geocodeAddressString(addressString) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                self?.processResponse(withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
         if let matches = placemarks {
            locations = matches.compactMap {
                guard let name = $0.administrativeArea else { return nil }
                return Location(cityId: -1, cityName: name, lastTemp: -100)
            }
            
            tableView.reloadData()
        }
    }
}

extension AddLocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AddLocationTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        let location = locations[indexPath.row]
        
        let viewModel = AddLocationViewModel(location: location)
        
        cell.setProperties(withViewModel: viewModel)
        
        return cell
    }
    
}

extension AddLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        
        delegate?.controller(self, didAddLocation: location)
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        geocode(addressString: searchBar.text)
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        locations = []
        tableView.reloadData()
    }
}
