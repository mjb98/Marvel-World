//
//  Image.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import Foundation

struct Image: Codable,Identifiable, Hashable {
    private let path: String
    private let `extension`: String
    
    var id: String {
        "\(path)\(`extension`)"
    }

    var url: URL? { URL(string: "\(path).\(`extension`)") }

    init(path: String, extension: String) {
        self.path = path
        self.extension = `extension`
    }
    
    
}
