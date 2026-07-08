//
//  LeagueUIModel+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Domain

extension League {
    func toUIModel() -> LeagueUI {
        LeagueUI(
            id: id,
            leagueName: name,
            leagueLogo: logo.orEmpty(),
            countryName: country.name,
        )
    }
}

extension Array where Element == League {
    func toUIModels() -> [LeagueUI] {
        map { $0.toUIModel() }
    }
}
