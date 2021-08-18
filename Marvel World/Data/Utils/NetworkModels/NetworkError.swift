//
//  NetworkError.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Foundation

enum NetworkError: Error {
    case InvalidEndpointError
    case customError(code: Int , message: String?)
    
}

