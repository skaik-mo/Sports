//
//  PlayerRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 03/08/2026.
//

public protocol PlayerRepository: Sendable {
    func getLeaguePlayers(sportType: SportType, leagueId: Int) async throws -> [Participant]
}
