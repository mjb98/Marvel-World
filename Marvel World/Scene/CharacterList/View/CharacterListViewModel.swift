//
//  CharacterListViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import Combine
import Foundation

class CharacterListViewModel: ObservableObject {
    @Published  var characters: [Character] = []
    @Published  var networkError: Error?
    @Published var isSearchBarHidden = false
    @Published var navigationTitle = "Characters"
    
    private let characterLoader: CharacterLoader
    private var queryText: String? {
        didSet {
            if (queryText ?? "").isEmpty{
                queryText = nil
            }
        }
    }
    
    var cancelables =  Set<AnyCancellable>()
    var isMoreDataAvailable = true
    let favouritesStorageController: FavouritesStroageController
    
    init(characterLoader: CharacterLoader = NetworkCharacterLoader(), favouritesStorageController: FavouritesStroageController = .init()) {
        self.characterLoader = characterLoader
        self.favouritesStorageController = favouritesStorageController
    }
  
    func fetchCharacters() {
        characterLoader.loadCharacters(offset: characters.count, query: self.queryText)
            .receive(on: RunLoop.main)
            .sinkToResult {[self] result in
                switch result {
                case .success(let response):
                    characters.append(contentsOf: response.results)
                    isMoreDataAvailable = response.total > characters.count
                     print(isMoreDataAvailable)
                    
                case .failure(let error):
                    networkError = error
                }
            }.store(in: &cancelables)
    }
    
   
    func didSearch(query: String) {
        isMoreDataAvailable = true
        self.queryText = query
        characters = []
    }
    
    func didCancelSearch() {
        isMoreDataAvailable = true
        if self.queryText != nil {
            self.queryText = nil
            characters = []
        }
        
    }
    
    func showFavouriteCharacters() {
        navigationTitle = "Favourite Characters"
        isMoreDataAvailable = false
        isSearchBarHidden = true
        characters = favouritesStorageController.fetchAll()
    }
    
    func hideFavouriteCharacters() {
        navigationTitle = "Characters"
        isMoreDataAvailable = true
        isSearchBarHidden = false
        characters = []
    }
    
    
}
