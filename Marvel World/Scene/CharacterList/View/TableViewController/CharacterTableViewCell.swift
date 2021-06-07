//
//  CharacterTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import UIKit

class CharacterTableViewCell: BindableTableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! 
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    var character: Character?
    
    
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        let cont = FavouritesStroageController()
        guard let char = character else { return }
        print(cont.contains(char))
        cont.contains(char) ? cont.remove(char) : cont.add(char)
        favouriteButton.isSelected = cont.contains(char)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func bind(data: Character) {
        titleLabel.text = data.name
        if let url = data.thumbnail?.url {
            thumbnailImageView.loadImage(at: url)
        }
        favouriteButton.isSelected = FavouritesStroageController().contains(data)
        self.character = data
    }
    
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
    }
}


