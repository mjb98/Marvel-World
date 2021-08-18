//
//  ShowAppearanceCellViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import Foundation

class AppearanceCellViewModel {
    
    // MARK: - Private  Properties
    private let type: AppearanceType
    
    // MARK: - Public  Properties
    let buttonAction: () -> ()
  
    // MARK: - Computed  Properties
    var title: String {
        "show \(type)"
    }
    
    // MARK: - Intilizer
    init(type: AppearanceType, buttonAction: @escaping () -> ()) {
        self.buttonAction = buttonAction
        self.type = type
    }
    
    
}
