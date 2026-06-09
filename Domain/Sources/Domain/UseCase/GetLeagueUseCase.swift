//
//  GetLeagueUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

class GetLeagueUseCase {
    private let repository: LeagueRepository

    init(repository: LeagueRepository) {
        self.repository = repository
    }

    func execute(sport: SportType, leagueId: Int) async throws -> League {
        try await repository.getLeague(sport: sport, id: leagueId)
    }
}
