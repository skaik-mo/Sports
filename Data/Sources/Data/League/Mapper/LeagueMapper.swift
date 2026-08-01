//
//  LeagueMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Domain

extension LeagueDto {
    func toDomain(sportType: SportType) -> League {
        var country: Country? = nil
        if let country_key {
            country = Country(
                id: country_key,
                name: country_name.orEmpty(),
                logo: country_logo
            )
        }
        return League(
            id: league_key,
            name: league_name.orEmpty(),
            logo: league_logo,
            country: country,
            sportType: sportType
        )
    }

    func toCache(sportPath: String) -> LeagueCache {
        LeagueCache(
            id: league_key,
            name: league_name.orEmpty(),
            logo: league_logo,
            sport: sportPath,
            countryId: country_key,
            countryName: country_name.orEmpty(),
            countryLogo: country_logo
        )
    }
}

extension LeagueCache {

    func toDomain() -> League {
        var country: Country? = nil
        if let countryId {
            country = Country(
                id: countryId,
                name: countryName,
                logo: countryLogo
            )
        }
        return League(
            id: id,
            name: name,
            logo: logo,
            country: country,
            sportType: SportType(path: sport)
        )
    }
}
