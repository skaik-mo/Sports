//
//  GetAllLeaguesUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//


public final class GetAllLeaguesUseCase: Sendable {  
    private let repository: LeagueRepository

    public init(repository: LeagueRepository) {
        self.repository = repository
    }

    public func execute(sportType: SportType) async throws -> [League] {
        try await repository.getAllLeagues(sportType: sportType)
    }
}
