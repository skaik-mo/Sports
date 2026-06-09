//
//  GetTeamsUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

class GetTeamsUseCase {
    private let repository: EventRepository

    init(repository: EventRepository) {
        self.repository = repository
    }

    func execute(sport: SportType, leagueId: Int) async throws -> [Team] {
        try await repository.GetTeams(sport: sport, leagueId: leagueId)
    }
}
