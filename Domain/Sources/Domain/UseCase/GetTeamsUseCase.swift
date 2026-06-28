//
//  GetTeamsUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public class GetTeamsUseCase {
    private let repository: TeamRepository

    public init(repository: TeamRepository) {
        self.repository = repository
    }

    public func execute(sportType: SportType, leagueId: Int) async throws -> [Team] {
        try await repository.getLeagueTeams(sportType: sportType, leagueId: leagueId)
    }
}
