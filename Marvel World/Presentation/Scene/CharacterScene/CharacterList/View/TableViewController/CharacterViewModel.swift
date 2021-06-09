//
//  CharacterCellViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Foundation

class CharacterViewModel {
    // MARK: - Private Properties
    private let favouriteStroageController: FavouritesStroageController
    // MARK: - Public Properties
    let character: Character
    
    // MARK: - Computed Properties
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
    // MARK: - Initilize
    init(character: Character, favouriteStroageController: FavouritesStroageController) {
        self.favouriteStroageController = favouriteStroageController
        self.character = character
    }
    
    // MARK: - Set Favourite
    func modifyFavouriteState() {
        isFavourited ? removeCharacterFromFavourites() : setCharacterFavourite()
    }
    
    private func setCharacterFavourite() {
        favouriteStroageController.add(character)
    }
    
    private func removeCharacterFromFavourites() {
        favouriteStroageController.remove(character)
    }
    
}

// MARK: - Hashable
extension CharacterViewModel: Hashable {
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        rhs.character == lhs.character
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(character)
    }
}
