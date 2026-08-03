//
//  TeamRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 27/06/2026.
//

public protocol TeamRepository: Sendable {
    func getLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Participant]
}
