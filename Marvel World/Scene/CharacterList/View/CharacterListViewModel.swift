//
//  CharacterListViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import Combine
import Foundation

class CharacterListViewModel: ObservableObject {
    private var characters: [Character] = []
    private let characterLoader: CharacterLoader
    
    init(characterLoader: CharacterLoader = NetworkCharacterLoader()) {
        self.characterLoader = characterLoader
    }
}
