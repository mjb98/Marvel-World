//
//  CharacterLoader.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import Foundation

protocol CharacterLoader {
    func loadCharacters(offset: Int, query: String?)-> AnyPublisher<ResponseData<[Character]>, Error>
    func loadCharacterAppearances(type: AppearanceType, characterId: String) -> AnyPublisher<ResponseData<[Appearance]>, Error>
   
}

struct NetworkCharacterLoader: CharacterLoader  {
    var urlSession: URLSession
    
    func loadCharacters(offset: Int, query: String? = nil) -> AnyPublisher<ResponseData<[Character]>, Error> {
        urlSession.publisher(for: .getCharacters(offset: offset, startWith: query))
    }
    
    func loadCharacterAppearances(type: AppearanceType, characterId: String) -> AnyPublisher<ResponseData<[Appearance]>, Error> {
        urlSession.publisher(for: .getAppearances(type: type, characterID: characterId))
    }
    
    
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}
