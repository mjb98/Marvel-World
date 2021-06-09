//
//  Appearance.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Foundation

struct Appearance: Codable, Identifiable {
    var id: Int
    var title, description: String?
    var thumbnail: Image?
}

struct AppearanceSummary: Codable, Equatable, Hashable {
    let name: String?
    let resourceURI: String?
}
struct AppearanceSummaryList: Codable, Equatable, Hashable {
    let items: [AppearanceSummary]
}
enum AppearanceType: String, CaseIterable, Equatable {
    case comics
    case series
    case events
    case stories
}

