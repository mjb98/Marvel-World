//
//  Router.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//


import UIKit

protocol Router {
   func route(
      to routeID: String,
      from context: UIViewController,
    parameters: [DataSourceKey: Any]?
   )
    
}

enum DataSourceKey: String {
    case character
}
