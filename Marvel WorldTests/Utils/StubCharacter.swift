//
//  StubCharacter.swift
//  Marvel WorldTests
//
//  Created by Mohammad Javad Bashtani on 3/20/1400 AP.
//

import Foundation
@testable import Marvel_World

struct StubCharacter {
    
     static func decodeCharacters() -> ResponseData<[Character]> {
        let path = Bundle(for: MockCharacterloader.self).path(forResource: "characters", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let jsonData = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(ResponseData<[Character]>.self, from: jsonData)
    }
    
    static func getCharacters() -> [Character] {
        decodeCharacters().results
    }
    
    static func getCharacter() -> Character {
        let characters = getCharacters()
        return characters[Int.random(in: 0 ..< characters.count)]
    }
    
    
}
