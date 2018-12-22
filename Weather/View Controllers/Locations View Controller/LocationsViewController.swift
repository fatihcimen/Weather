//
//  LocationsViewController.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController {
    
    private let addLocationSegue = "AddLocationSegue"
    
    // MARK - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentLocation: CLLocation?
    var addedLocations = UserDefaults.getLocations()
    
    var delegate: LocationsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecent()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case addLocationSegue:
            if let addLocationViewController = segue.destination as? AddLocationViewController {
                addLocationViewController.delegate = self
            }else { fatalError("AddLocationSegue Error") }
        default: break
        }
    }
    
    // MARK: - Get Recent Conditions
    private func getRecent() {
        guard addedLocations.count > 0 else { return }
        
        let ids = addedLocations.map{String(describing: $0.cityId)}.joined(separator:",")
        
        let network = NetworkManager.init(weatherRequestType: .group, parameters: ["APPID": APIConfigurations.apiKey, "id": ids, "units": self.getUnitParameter()])
        
        network.get(type: Group.self) { data in
            if let weatherData = data {
                self.removeAllLocations()
                
                let _ = weatherData.groupWeather.map {
                    let location = Location(cityId: $0.id, cityName: $0.name, lastTemp: $0.main.temp)
                    self.addedLocations.append(location)
                }
                
                UserDefaults.saveLocations(locations: self.addedLocations)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Helper
    
    private func removeAllLocations() {
        UserDefaults.deleteAllLocations()
        addedLocations.removeAll()
        self.tableView.reloadData()
    }
    
    private func getUnitParameter() -> String {
        switch UserDefaults.getTemperature() {
        case .celsius: return "metric"
        case .fahrenheit: return "imperial"
        }
    }
}

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? LocationsTableViewCell else { fatalError("LocationTableViewCell Error")}
        
        let addedLocation = addedLocations[indexPath.row]
        
        let viewModel: LocationsProtocol? = LocationsViewModel(locationData: addedLocation)
        
        if let viewModel = viewModel {
            cell.setProperties(withViewModel: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let location = addedLocations[indexPath.row]
        
        addedLocations.remove(at: indexPath.row)
        
        UserDefaults.deleteLocation(location: location)
        
        tableView.reloadData()
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let location = addedLocations[indexPath.row]
        
        delegate?.controller(self, didSelectLocation: location)
        
        dismiss(animated: true)
    }
}

extension LocationsViewController: AddLocationDelegate {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location) {
        let network = NetworkManager.init(weatherRequestType: .weather, parameters: ["APPID": APIConfigurations.apiKey, "q": location.cityName, "units": self.getUnitParameter()])
        
        network.get(type: CurrentWeather.self) { data in
            if let weatherData = data {                
                var locationWithCityId = location
                locationWithCityId.cityId = weatherData.id
                locationWithCityId.lastTemp = weatherData.main.temp
                
                UserDefaults.addLocation(location: locationWithCityId)
                
                self.addedLocations.append(locationWithCityId)
                
                self.tableView.reloadData()
            }
        }
    }
}
