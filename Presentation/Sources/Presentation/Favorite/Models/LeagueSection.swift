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

extension Array where Element == LeagueSection {
    func filtered(by searchText: String) -> [LeagueSection] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return self }

        return compactMap { section in
            let matchingLeagues = section.leagues.filter { $0.matches(query: query) }
            guard !matchingLeagues.isEmpty else { return nil }
            return LeagueSection(sportType: section.sportType, leagues: matchingLeagues)
        }
    }
}
