//
//  CharacterListViewModel.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import Combine
import Foundation

class CharacterListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published  var characters: [Character] = []
    @Published  var networkError: Error?
    @Published var isSearchBarHidden = false
    @Published var navigationTitle = "Characters"
    
    // MARK: - Private Properties
    private let characterLoader: CharacterLoader
    private var queryText: String? {
        didSet {
            if (queryText ?? "").isEmpty{
                queryText = nil
            }
        }
    }
    
    // MARK: - Publis Properties
    var cancelables =  Set<AnyCancellable>()
    var isMoreDataAvailable = true
    var searchbarPlaceHolder: String = "Search..."
    let favouritesStorageController: FavouriteStorageController
    
    // MARK: - Initilizer
    init(characterLoader: CharacterLoader, favouritesStorageController: FavouriteStorageController) {
        self.characterLoader = characterLoader
        self.favouritesStorageController = favouritesStorageController
    }
    
    // MARK: - Fetch Data
    func fetchCharacters() {
        characterLoader.loadCharacters(offset: characters.count, query: self.queryText)
            .receive(on: RunLoop.main)
            .sinkToResult {[self] result in
                switch result {
                case .success(let response):
                    characters.append(contentsOf: response.results)
                    isMoreDataAvailable = response.total > characters.count
                
                case .failure(let error):
                    networkError = error
                }
            }.store(in: &cancelables)
    }
    
    // MARK: - Search Handleing
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
    
    
    // MARK: - Favourite Handling
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
