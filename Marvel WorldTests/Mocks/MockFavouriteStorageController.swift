//
//  MockFavouriteStorageController.swift
//  Marvel WorldTests
//
//  Created by Mohammad Javad Bashtani on 3/20/1400 AP.
//

import Foundation
@testable import Marvel_World

class MockFavouriteStorageController: FavouriteStorageController {
    var characterArray: [Character] = []
    func save(_ characters: [Character]) {
        characterArray = characters
    }
    
    func fetchAll() -> [Character] {
        characterArray
    }
    
    func removeAll() {
        characterArray.removeAll()
    }
    
    func add(_ character: Character) {
        characterArray.append(character)
    }
    
    func remove(_ character: Character) {
        characterArray.removeAll {
            character == $0
        }
    }
    
    func contains(_ character: Character) -> Bool {
        characterArray.contains(character)
    }
    
    
}
