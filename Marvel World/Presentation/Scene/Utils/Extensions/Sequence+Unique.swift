//
//  Sequence+Unique.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

