//
//  Endpoints.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Foundation

extension Endpoint where Response == ResponseData<[Character]> {
    static func getCharacters(offset: Int) -> Self {
        Endpoint(path: "v1/public/characters", queryItems: [.init(name: "offset", value: "\(offset)")])
    }
}
