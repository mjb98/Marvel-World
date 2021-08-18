//
//  Character.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/9/1400 AP.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name, description: String?
    let thumbnail: Image?
    let comics, stories, events, series: AppearanceSummaryList?

}
