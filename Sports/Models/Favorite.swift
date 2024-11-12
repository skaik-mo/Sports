//
//  Favorite.swift
//  Sports
//
//  Created by Mohammed Skaik on 24/10/2024.
//

import SwiftData
import SportTypeKit

@Model
final class Favorite {
    @Attribute(.unique)
    var id: Int
    @Relationship(deleteRule: .cascade)
    var league: League
    var sport: SportType

    init(league: League, sport: SportType) {
        self.id = league.league_key ?? -1
        self.league = league
        self.sport = sport
    }
}

typealias FavoriteGroup = (sport: String, favorites: [Favorite])

// The groupBySport function is a helper function that groups a list of favorites by their sport.
extension Array where Element == Favorite {
    func groupBySport() -> [FavoriteGroup] {
        return Dictionary(grouping: self) { $0.sport.rawValue }
            .sorted(by: { $0.key < $1.key })
            .map { ($0.key, $0.value) }
    }
}
