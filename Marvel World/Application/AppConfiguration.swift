//
//  AppConfigurations.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Foundation
import Foundation

 struct AppConfiguration {
    static var publicApiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "PublicApiKey") as? String, !apiKey.isEmpty else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    static var privateApiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "PrivateApiKey") as? String, !apiKey.isEmpty else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
 
}
