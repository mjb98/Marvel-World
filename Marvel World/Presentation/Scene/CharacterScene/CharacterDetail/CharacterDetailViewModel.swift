//
//  CharacterDetailViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import Combine
import Foundation

class CharacterDetailViewModel {
    // MARK: - Published Properties
    @Published var isLoading = false
    var appearancesFetched = PassthroughSubject<(list: [Appearance], type: AppearanceType), Error>()
    
    // MARK: - Private Properties
    private let characterLoader = NetworkCharacterLoader()
    
    // MARK: - Public Properties
    let character: Character
    var availableAppearnces: [AppearanceType] = []
    var cancelables =  Set<AnyCancellable>()
    let favouritesStorageController: FavouritesStroageController
    
    // MARK: - Intilize
    init(character: Character,favouritesStorageController:  FavouritesStroageController ) {
        self.character = character
        self.favouritesStorageController = favouritesStorageController
        availableAppearnces = setUpAvailableAppearnces(character: character)
        
    }
    
    // MARK: - Utlis
    private func setUpAvailableAppearnces(character: Character) -> [AppearanceType]  {
        let array =  AppearanceType.allCases.filter { type  in
              switch type {
              case .comics:
                return !(character.comics?.items.isEmpty ?? true)
              case .series:
                  return !(character.series?.items.isEmpty ?? true)
              case .events:
                  return !(character.events?.items.isEmpty ?? true)
              case .stories:
                  return !(character.stories?.items.isEmpty ?? true)
              }
          }
          return array
    }
    
    // MARK: - Fetch Data
    func fetchAppearances(type: AppearanceType) {
        isLoading = true
        characterLoader
            .loadCharacterAppearances(type: type, characterId: character.id.description)
            .sinkToResult { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.appearancesFetched.send((list: data.results, type: type))
                case .failure(let error):
                    self?.appearancesFetched.send(completion: .failure(error))
                }
            }.store(in: &cancelables)
    }
    
}
