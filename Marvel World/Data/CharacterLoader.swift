//
//  CharacterLoader.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import Foundation

protocol CharacterLoader {
    func loadCharacters(offset: Int)-> AnyPublisher<ResponseData<[Character]>, Error>
}

struct NetworkCharacterLoader: CharacterLoader  {
    var urlSession: URLSession
    
    func loadCharacters(offset: Int)-> AnyPublisher<ResponseData<[Character]>, Error> {
        urlSession.publisher(for: .getCharacters(offset: offset))
    }
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}
