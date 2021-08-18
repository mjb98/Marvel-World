//
//  HeaderTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/18/1400 AP.
//

import UIKit

class CharacterHeaderTableViewCell: BindableTableViewCell {
    // MARK: - Private  Properties
    private var viewModel: CharacterViewModel!
    
    // MARK: - Outlets
    @IBOutlet private var characterImageView: UIImageView!
    @IBOutlet private var nameTitleLabel: UILabel!
    @IBOutlet private var nameValueLabel: UILabel!
    @IBOutlet private var descriptionTitleLabel: UILabel!
    @IBOutlet private var descriptionValueLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    // MARK: - Initlizer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
        
    }
    
    // MARK: - Handle Favourite
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        viewModel.modifyFavouriteState()
        favouriteButton.isSelected =  viewModel.isFavourited
    }
    // MARK: - Bind ViewModel
    func bind(data viewModel:  CharacterViewModel) {
        self.viewModel = viewModel
        setUpView()
    }
    
    // MARK: - SetUp View
    private func setUpView() {
        if let url =  viewModel.imageUrl {
            characterImageView.loadImage(at: url)
        }
        nameValueLabel.text = viewModel.title
        descriptionValueLabel.text = viewModel.description
        descriptionTitleLabel.isHidden = viewModel.isDescriptionEmpty
        favouriteButton.isSelected = viewModel.isFavourited
    }
}



