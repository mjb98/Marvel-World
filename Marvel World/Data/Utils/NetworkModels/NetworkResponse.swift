//
//  NetworkResponse.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/16/1400 AP.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    let code: Int
    let message: String?
    let data: Wrapped?
}

struct ResponseData<Wrapped: Decodable>: Decodable {
    let results: Wrapped
  
}
