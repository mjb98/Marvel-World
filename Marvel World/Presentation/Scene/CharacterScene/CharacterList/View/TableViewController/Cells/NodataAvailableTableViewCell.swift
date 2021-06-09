//
//  NoDataAvailableTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit


class NoDataAvailableTableViewCell: UITableViewCell {
    
    // MARK: - Initilize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare UI
    private func prepareUI() {
        let label = UILabel()
        label.text = "There are no data available!"
        label.font = UIFont(name: "avenir", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        isUserInteractionEnabled = true
    }
    
    
}
