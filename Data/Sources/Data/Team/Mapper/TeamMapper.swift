//
//  TeamMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain

extension TeamDto {
    func toDomain() -> Team {
        Team(
            id: self.team_key,
            name: self.team_name,
            logoUrl: self.team_logo
        )
    }

    func toCache(leagueId: Int) -> TeamCache {
        TeamCache(
            id: self.team_key,
            name: self.team_name,
            logo: self.team_logo,
            leagueId: leagueId
        )
    }
}

extension TeamCache {
    func toDomain() -> Team {
        Team(
            id: self.id,
            name: self.name,
            logoUrl: self.logo
        )
    }
}
