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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func bind(data: Character) {
        titleLabel.text = data.name
        if let url = data.thumbnail?.url {
           thumbnailImageView.loadImage(at: url)
        }
        
    }
    
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
    }
}

