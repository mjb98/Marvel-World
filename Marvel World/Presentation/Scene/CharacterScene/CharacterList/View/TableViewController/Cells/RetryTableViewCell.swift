//
//  RetryTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit


class RetryTableViewCell: BindableTableViewCell {
    // MARK: - Private Propeties
    private let retryButton = UIButton(type: .system)
    
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
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(retryButton)
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        retryButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        retryButton.setTitle("Retry", for: .normal)
        retryButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        retryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        retryButton.setTitleColor(.blue, for: .normal)
        isUserInteractionEnabled = true
    }
    
    // MARK: - Bind ViewModel
    func bind(data action : UIAction) {
        retryButton.addAction(action, for: .touchUpInside)
    }
    
    
}
