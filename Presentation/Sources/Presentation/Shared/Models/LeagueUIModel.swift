//
//  LeagueUIModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import Domain

struct LeagueUIModel: Identifiable {
    let id: Int
    let leagueName: String
    let leagueLogo: String
    let countryName: String
    let sportType: SportType
}
