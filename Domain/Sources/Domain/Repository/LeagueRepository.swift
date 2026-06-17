//
//  LeagueRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public protocol LeagueRepository {
    func getAllLeagues(sport: SportType) async throws -> [League]
    func getLeague(sport: SportType, id: Int) async throws -> League
}
