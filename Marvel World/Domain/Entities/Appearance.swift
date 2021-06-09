//
//  Appearance.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Foundation

protocol Appearance: Identifiable {
    var id: Int { get }
    var title: String? { get }
    var thumbnail: Image? { get }
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

