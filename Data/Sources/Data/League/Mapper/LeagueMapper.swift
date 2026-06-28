//
//  LeagueMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Domain

extension LeagueDto {
    func toDomain() -> League {
        return League(
            id: league_key,
            name: league_name.orEmpty(),
            logo: league_logo.orEmpty(),
            country: Country(
                id: country_key,
                name: country_name.orEmpty(),
                logo: country_logo.orEmpty()
            )
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
            countryLogo: country_logo.orEmpty()
        )
    }
}

extension LeagueCache {

    func toSnapshot() -> LeagueCacheModel {
        LeagueCacheModel(
            id: id,
            name: name,
            logo: logo,
            sport: sport,
            countryId: countryId,
            countryName: countryName,
            countryLogo: countryLogo
        )
    }
}


extension LeagueCacheModel {

    func toDomain() -> League {
        League(
            id: id,
            name: name,
            logo: logo,
            country: Country(
                id: countryId,
                name: countryName,
                logo: countryLogo
            )
        )
    }
}
