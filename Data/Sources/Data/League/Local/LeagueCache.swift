//
//  LeagueCache.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//


import SwiftData

@Model
final class LeagueCache  {
    @Attribute(.unique)
    var cacheId: String
    
    var id: Int
    var name: String
    var logo: String?
    var sport: String
    var countryId: Int?
    var countryName: String
    var countryLogo: String?

    init(
        id: Int,
        name: String,
        logo: String?,
        sport: String,
        countryId: Int?,
        countryName: String,
        countryLogo: String?
    ) {
        self.cacheId = "\(id)-\(sport)"
        self.id = id
        self.name = name
        self.logo = logo
        self.sport = sport
        self.countryId = countryId
        self.countryName = countryName
        self.countryLogo = countryLogo
    }
}
