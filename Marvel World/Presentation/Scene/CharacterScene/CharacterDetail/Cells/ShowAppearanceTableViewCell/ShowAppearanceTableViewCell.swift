//
//  ShowAppearanceTableViewCell.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import UIKit

class ShowAppearanceTableViewCell: BindableTableViewCell {
    var showAppearanceButton = UIButton(type: .system)
    private var viewModel: AppearanceCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        selectionStyle = .none
        
    }
    
    private func setUp() {
        showAppearanceButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(showAppearanceButton)
        showAppearanceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        showAppearanceButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        showAppearanceButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showAppearanceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showAppearanceButton.titleLabel?.font = UIFont(name: "avenir", size: 16)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: AppearanceCellViewModel) {
        viewModel = data
        showAppearanceButton.setTitle(viewModel?.title, for: .normal)
        showAppearanceButton.addAction(.init(handler: { _ in
            data.buttonAction()
        }), for: .touchUpInside)
        
    }
    
    
}
