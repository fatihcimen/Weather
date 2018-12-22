//
//  ForecastViewController.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ForecastViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.numberOfForecast
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ForecastCollectionViewCell else { fatalError("CollectionView Error") }
        
        if let forecastProtocol = viewModel?.viewModel(for: indexPath.row) {
            cell.setProperties(withViewModel: forecastProtocol)
        }
        
        return cell
    }
}
