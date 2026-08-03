//
//  ParticipantMapper.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain

extension TeamDto {
    func toDomain() -> Participant? {
        guard let key = team_key else { return nil }
        return Participant(
            id: key,
            name: team_name,
            logoUrl: team_logo
        )
    }
}

extension PlayerDto {
    func toDomain() -> Participant? {
        guard let key = player_key else { return nil }
        return Participant(
            id: key,
            name: player_name,
            logoUrl: player_logo
        )
    }
}

extension Participant {
    func toCache(leagueId: Int, type: ParticipantType) -> ParticipantCache {
        ParticipantCache(
            id: id,
            name: name,
            logo: logoUrl,
            leagueId: leagueId,
            type: type
        )
    }
}

extension ParticipantCache {
    func toDomain() -> Participant {
        Participant(id: id, name: name, logoUrl: logo)
    }
}

extension Array where Element == TeamDto {
    func toDomain() -> [Participant] {
        compactMap { $0.toDomain() }
    }
}

extension Array where Element == PlayerDto {
    func toDomain() -> [Participant] {
        compactMap { $0.toDomain() }
    }
}
