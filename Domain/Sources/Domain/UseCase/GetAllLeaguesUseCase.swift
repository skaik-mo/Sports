//
//  GetAllLeaguesUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

class GetAllLeaguesUseCase {
    private let repository: LeagueRepository

    init(repository: LeagueRepository) {
        self.repository = repository
    }

    func execute(sport: SportType) async throws -> [League] {
        try await repository.getAllLeagues(sport: sport)
    }
}
