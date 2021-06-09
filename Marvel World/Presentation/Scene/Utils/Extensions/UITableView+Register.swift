//
//  UITableView+Register.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import Foundation

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_ cell: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.reuseIdentifier)")
        }
        return cell
    }
}
