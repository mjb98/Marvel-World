//
//  CharacterTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import UIKit

class CharacterTableViewCell: BindableTableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var labelBackgroundView: UIView!
    @IBOutlet private weak var favouriteButton: UIButton!
 
    // MARK: - Private Properties
    private var viewModel: CharacterViewModel!
    
    // MARK: - Outelet Actions
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        viewModel.modifyFavouriteState()
        favouriteButton.isSelected =  viewModel.isFavourited
    }
  
    // MARK: - Prepare UI
    private func setUpView() {
        titleLabel.text = viewModel.title
        if let url = viewModel.imageUrl {
            thumbnailImageView.loadImage(at: url)
        }
        favouriteButton.isSelected = viewModel.isFavourited
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
    }
    // MARK: - Binding ViewModel
    func bind(data viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        setUpView()
    }
    
}


