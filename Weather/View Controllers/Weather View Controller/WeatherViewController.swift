//
//  WeatherViewController.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: View Model
    
    var viewModel: WeatherViewModel? {
        didSet {
            setProperties()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setProperties() {
        guard let viewModel = viewModel else {
            showStatusBarAlert(title: "weatherDataCannotFetched".localized)
            return
        }
        
        weatherConditionImageView.kf.setImage(with: viewModel.weatherImageURL)
        weatherDescriptionLabel.text = viewModel.description
        temperatureLabel.text = viewModel.temperature
    }
}
