//
//  CharacterCellViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Foundation

class CharacterViewModel {
    private let favouriteStroageController: FavouritesStroageController
    
    let character: Character
    
    var title: String {
        character.name ?? ""
    }
    
    var description: String {
        character.description ?? ""
    }
    
    var isDescriptionEmpty: Bool {
        description.isEmpty
    }
    
    var imageUrl: URL? {
        character.thumbnail?.url
    }
    
    var isFavourited: Bool {
        favouriteStroageController.contains(character)
    }
    
    func modifyFavouriteState() {
        isFavourited ? removeCharacterFromFavourites() : setCharacterFavourite()
    }
    
    private func setCharacterFavourite() {
        favouriteStroageController.add(character)
    }
    
    private func removeCharacterFromFavourites() {
        favouriteStroageController.remove(character)
    }
    
    init(character: Character, favouriteStroageController: FavouritesStroageController) {
        self.favouriteStroageController = favouriteStroageController
        self.character = character
    }
    
}


extension CharacterViewModel: Hashable {
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        rhs.character == lhs.character
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
    }
}
