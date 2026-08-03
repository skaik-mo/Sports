//
//  GetPlayersUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 03/08/2026.
//


public final class GetPlayersUseCase: Sendable {
    private let repository: PlayerRepository

    public init(repository: PlayerRepository) {
        self.repository = repository
    }

    public func execute(sportType: SportType, leagueId: Int) async throws -> [Participant] {
        try await repository.getLeaguePlayers(sportType: sportType, leagueId: leagueId)
    }
}
