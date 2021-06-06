//
//  CharacterLoader.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Combine
import Foundation

struct CharacterLoader {
    var urlSession = URLSession.shared
   
    func loadCharacters(offset: Int)-> AnyPublisher<ResponseData<[Character]>, Error> {
        urlSession.publisher(for: .getCharacters(offset: offset))
    }
}
