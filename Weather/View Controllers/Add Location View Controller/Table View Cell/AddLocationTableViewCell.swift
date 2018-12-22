//
//  AddLocationTableViewCell.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import UIKit

class AddLocationTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProperties(withViewModel viewModel: AddLocationProtocol) {
        cityNameLabel.text = viewModel.cityName
    }

}
