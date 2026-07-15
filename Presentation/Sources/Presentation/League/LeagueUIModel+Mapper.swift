//
//  LeagueUIModel+Mapper.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Domain

extension League {
    func toUIModel() -> LeagueUIModel {
        LeagueUIModel(
            id: id,
            leagueName: name,
            leagueLogo: logo.orEmpty(),
            countryName: country.name,
            sportType: sportType
        )
    }
}

extension Array where Element == League {
    func toUIModels() -> [LeagueUIModel] {
        map { $0.toUIModel() }
    }
}
