//
//  LoadingTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    // MARK: - Private Properties
    private let indictor = UIActivityIndicatorView()
    
    // MARK: - Intilize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare UI
    private func  prepareUI() {
        indictor.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indictor)
        indictor.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indictor.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    // MARK: - HandleLoading
    
    func startAnimation() {
        indictor.startAnimating()
    }
    
   
    
}
