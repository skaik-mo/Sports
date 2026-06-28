//
//  LeagueRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public protocol LeagueRepository {
    func getAllLeagues(sportType: SportType) async throws -> [League]
}
