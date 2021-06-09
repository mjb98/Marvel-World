//
//  HeaderTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/18/1400 AP.
//

import UIKit

class CharacterHeaderTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet private var characterImageView: UIImageView!
    @IBOutlet private var nameTitleLabel: UILabel!
    @IBOutlet private var nameValueLabel: UILabel!
    @IBOutlet private var descriptionTitleLabel: UILabel!
    @IBOutlet private var descriptionValueLabel: UILabel!

    // MARK: - LifeCycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
     
    }
}

extension CharacterHeaderTableViewCell {
    func configure(with item:  Character) {
        if let url =  item.thumbnail?.url {
            characterImageView.loadImage(at: url)
        }
        nameValueLabel.text = item.name
        descriptionValueLabel.text = item.description
        descriptionTitleLabel.isHidden = (item.description ?? "").isEmpty
    }
}
