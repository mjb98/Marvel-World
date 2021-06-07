//
//  Endpoints.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Foundation

extension Endpoint where Response == ResponseData<[Character]> {
    static func getCharacters(offset: Int, startWith: String? = nil) -> Self {
        var queryItems = [URLQueryItem(name: "offset", value: "\(offset)")]
        if let queryText = startWith  {
            queryItems.append(.init(name: "nameStartsWith", value: queryText))
        }
        return Endpoint(path: "v1/public/characters", queryItems: queryItems)
    }
}
