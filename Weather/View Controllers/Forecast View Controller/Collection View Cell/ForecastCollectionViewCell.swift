//
//  ForecastCollectionViewCell.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setProperties(withViewModel viewModel: ForecastProtocol) {
        imageView.kf.setImage(with: viewModel.forecastImageURL)
        timeLabel.text = viewModel.time
        temperatureLabel.text = viewModel.temperature
    }
}
