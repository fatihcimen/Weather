//
//  RootViewController.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit
import SPPermission
import CoreLocation

class RootViewController: UIViewController {
    
    // MARK: - Constants
    
    private let weatherViewSegue = "WeatherViewSegue"
    private let forecastViewSegue = "ForecastViewSegue"
    private let locationViewSegue = "LocationViewSegue"
    private let settingsViewSegue = "SettingsViewSegue"
    private let detailViewSegue = "DetailViewSegue"
    
    // MARK: - Properties
    
    @IBOutlet weak var cityNameButton: UIButton!
    @IBOutlet private var weatherViewController: WeatherViewController!
    @IBOutlet private var forecastViewController: ForecastViewController!
    
    private var currentLocation: CLLocation? {
        didSet {
            getWeatherData()
        }
    }
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request Permission
        getLocationPermission()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case weatherViewSegue:
            guard let destination = segue.destination as? WeatherViewController else {
                fatalError("WeatherViewController Segue Error")
            }
            
            weatherViewController = destination
        case forecastViewSegue:
            guard let destination = segue.destination as? ForecastViewController else {
                fatalError("ForecastViewController Segue Error")
            }
            
            forecastViewController = destination
        case locationViewSegue:
            guard let navigationController = segue.destination as? UINavigationController else { fatalError("LocationViewController Navigation Error") }
            guard let destination = navigationController.topViewController as? LocationsViewController else { fatalError("LocationViewController Error") }
            
        destination.delegate = self
        case detailViewSegue:
            guard let destination = segue.destination as? ForecastDetailViewController else { fatalError("ForecastDetailViewController Segue Error") }
            
            destination.viewModel = self.forecastViewController.viewModel
        default: break
        }
    }
    
    // MARK: - Location Permission Request
    
    private func getLocationPermission() {
        locationManager.delegate = self
        
        guard !SPPermission.isAllow(.locationWhenInUse) else {
            locationManager.requestLocation()
            return
        }
        
        SPPermission.Dialog.request(with: [.locationWhenInUse], on: self, delegate: self)
    }
    
    // MARK: - Getting Weather Data
    
    private func getWeatherData() {
        guard let location = currentLocation else { return }
        
         city(fromCLLocation: location) { city in
            self.getWeatherData(withCity: city)
        }
    }
    
    private func getWeatherData(withCity name: String) {
        // Button Name Change
        cityNameButton.setTitle("▼ \(name)", for: .normal)
        
        self.getCurrentWeatherData(city: name, requestType: .weather, type: CurrentWeather.self)
        self.getCurrentWeatherData(city: name, requestType: .forecast, type: Forecast.self)
    }
    
    private func getCurrentWeatherData<T: Codable>(city: String, requestType: WeatherRequestType, type: T.Type?) {
        let network = NetworkManager.init(weatherRequestType: requestType, parameters: ["APPID": APIConfigurations.apiKey, "q": city, "units": self.getUnitParameter()])
        
        network.get(type: T.self) { data in
            if let weatherData = data {
                
                // Initialize Weather View Model
                switch requestType {
                case .weather: self.weatherViewController.viewModel = WeatherViewModel(weatherData: weatherData as! CurrentWeather)
                case .forecast: self.forecastViewController.viewModel = ForecastViewModel(forecastData: weatherData as! Forecast, date: Date())
                case .group: break
                }
            }
        }
    }
    
    private func getUnitParameter() -> String {
        switch UserDefaults.getTemperature() {
        case .celsius: return "metric"
        case .fahrenheit: return "imperial"
        }
    }
    
    // MARK: - Unwind
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        
    }
}

extension RootViewController: CLLocationManagerDelegate {
    
    // MARK: - Location Authorization
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            // Request Location
            manager.requestLocation()
        default: break
        }
    }
    
    // MARK: - Updated Location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            // Getting Default Lantitude Longitude
            currentLocation = CLLocation(latitude: Defaults.latitude, longitude: Defaults.longitude)
            
            return
        }
        
        // Update Location
        
        currentLocation = location
        
        // Stop Getting Location
        manager.delegate = nil
        manager.stopUpdatingLocation()
    }
    
    // MARK: - Location Fails
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if currentLocation == nil {
            currentLocation = CLLocation(latitude: Defaults.latitude, longitude: Defaults.longitude)
        }
    }
}

// MARK: - Selected Location Callback

extension RootViewController: LocationsDelegate {
    func controller(_ controller: LocationsViewController, didSelectLocation location: Location) {
        getWeatherData(withCity: location.cityName)
    }
}

// MARK: Location Request Delegate

extension RootViewController: SPPermissionDialogDelegate {
    func didHide() {
        currentLocation = CLLocation(latitude: Defaults.latitude, longitude: Defaults.longitude)
    }
}
