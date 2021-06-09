//
//  AppearanceTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class AppearanceTableViewCell: BindableTableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
        
    }
    
    // MARK: - Bindig Data
    func bind(data: Appearance) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
        if let url = data.thumbnail?.url {
            thumbnailImageView.loadImage(at: url)
        }
    }
    
  
}
