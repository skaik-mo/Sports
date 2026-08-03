//
//  GetTeamsUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 03/08/2026.
//


public final class GetTeamsUseCase: Sendable {
    private let repository: TeamRepository

    public init(repository: TeamRepository) {
        self.repository = repository
    }

    public func execute(sportType: SportType, leagueId: Int) async throws -> [Participant] {
        try await repository.getLeagueTeams(sportType: sportType, leagueId: leagueId)
    }
}
