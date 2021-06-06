//
//  Endpoint.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Foundation


struct Endpoint<Response: Decodable> {
    var path: String
    var queryItems = [URLQueryItem]()
}

extension Endpoint {
    
    var publicApiKeyParam: URLQueryItem {
        URLQueryItem(name: "apikey", value: AppConfiguration.publicApiKey)
    }
    func timeStampParam(date: Date) -> URLQueryItem {
        return URLQueryItem(name: "ts", value: date.timeIntervalSince1970.description)
    }
    
    func hashParam(date: Date) -> URLQueryItem {
        let hashed =  "\(date.timeIntervalSince1970)\(AppConfiguration.privateApiKey)\(AppConfiguration.publicApiKey)".md5
        return URLQueryItem(name: "hash", value: hashed)
        
    }
    
    func makeRequest() -> URLRequest? {
        let date = Date()
        let commonQueryItems = [
            timeStampParam(date: date) , publicApiKeyParam, hashParam(date: date)
        ]
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = "/" + path
        components.queryItems = commonQueryItems + queryItems
        
        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components.url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}



