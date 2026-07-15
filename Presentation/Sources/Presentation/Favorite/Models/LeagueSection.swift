//
//  LeagueSection.swift
//  Presentation
//
//  Created by Mohammed Skaik on 15/07/2026.
//

import Domain

struct LeagueSection: Identifiable {
    var id: SportType { sportType }
    let sportType: SportType
    let leagues: [LeagueUIModel]
}

extension Array where Element == LeagueUIModel {
    func groupedBySportTypeSections() -> [LeagueSection] {
        Dictionary(grouping: self, by: \.sportType)
            .map { LeagueSection(sportType: $0.key, leagues: $0.value) }
            .sorted { $0.sportType.title < $1.sportType.title }
    }
}
