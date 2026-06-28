//
//  TeamRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 27/06/2026.
//

public protocol TeamRepository {
    func getLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Team]
}
