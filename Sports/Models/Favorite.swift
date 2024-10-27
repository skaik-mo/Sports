//
//  Favorite.swift
//  Sports
//
//  Created by Mohammed Skaik on 24/10/2024.
//

import SwiftData

@Model
final class Favorite {
    @Attribute(.unique)
    var id: Int
    @Relationship(deleteRule: .cascade)
    var league: League
    var sport: Sports

    init(league: League, sport: Sports) {
        self.id = league.league_key ?? -1
        self.league = league
        self.sport = sport
    }
}
