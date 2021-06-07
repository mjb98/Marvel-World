//
//  CharacterTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import UIKit

class CharacterTableViewCell: BindableTableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 25
            
        }
    }
    @IBOutlet weak var titleLabel: UILabel! 
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
 
    private var viewModel: CharacterCellViewModel!
    
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        viewModel.modifyFavouriteState()
        favouriteButton.isSelected =  viewModel.isFavourited
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func bind(data: CharacterCellViewModel) {
        self.viewModel = data
        titleLabel.text = data.title
        if let url = data.imageUrl {
            thumbnailImageView.loadImage(at: url)
        }
        favouriteButton.isSelected = viewModel.isFavourited
      
    }
    
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
    }
}


