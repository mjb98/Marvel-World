//
//  MockCharacterLoader.swift
//  Marvel WorldTests
//
//  Created by Mohammad Javad Bashtani on 3/20/1400 AP.
//

import Combine
import Foundation
@testable import Marvel_World

class MockCharacterloader: CharacterLoader {
   static var souldFail = false
    func loadCharacters(offset: Int, query: String?) -> AnyPublisher<ResponseData<[Character]>, Error> {
        let characters = StubCharacter.decodeCharacters()
        return Future<ResponseData<[Character]>, Error> { promise in
            if MockCharacterloader.souldFail {
                promise(.failure(NetworkError.InvalidEndpointError))
            }
            promise(.success(characters))
        }.eraseToAnyPublisher()
        
    }
    
    func loadCharacterAppearances(type: AppearanceType, characterId: String) -> AnyPublisher<ResponseData<[Appearance]>, Error> {
        fatalError()
    }
    
}
