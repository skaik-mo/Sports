//
//  GetAllLeaguesUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public class GetAllLeaguesUseCase {
    private let repository: LeagueRepository

    public init(repository: LeagueRepository) {
        self.repository = repository
    }

    public func execute(sport: SportType) async throws -> [League] {
        try await repository.getAllLeagues(sport: sport)
    }
}
