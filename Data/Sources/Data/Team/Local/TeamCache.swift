//
//  TeamCache.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//

import SwiftUI
import SwiftData

@Model
final class TeamCache {
    @Attribute(.unique)
    var id: Int
    var name: String
    var logo: String
    var leagueId: Int

    init(id: Int, name: String, logo: String, leagueId: Int) {
        self.id = id
        self.name = name
        self.logo = logo
        self.leagueId = leagueId
    }
}
