//
//  Bindable.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Foundation
import UIKit

protocol Bindable {
    associatedtype T
    func bind(data: T)
}
extension Bindable {
    func bind(data: T) {
        
    }
}

typealias BindableTableViewCell = Bindable & UITableViewCell
