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
    private let characterLoader: CharacterLoader
     var cancelables =  Set<AnyCancellable>()
    var isMoreDataAvailable = true
    
    init(characterLoader: CharacterLoader = NetworkCharacterLoader()) {
        self.characterLoader = characterLoader
    }
  
    func fetchCharacters() {
        characterLoader.loadCharacters(offset: characters.count)
            .receive(on: RunLoop.main)
            .sinkToResult {[self] result in
                switch result {
                case .success(let response):
                    characters.append(contentsOf: response.results)
                    isMoreDataAvailable = response.total <= characters.count
                    
                case .failure(let error):
                    networkError = error
                }
            }.store(in: &cancelables)
    }
    
   
    
}
