//
//  RemoveFavoriteUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 14/07/2026.
//


public final class RemoveFavoriteUseCase: Sendable {
    private let repository: FavoriteRepository

    public init(repository: FavoriteRepository) {
        self.repository = repository
    }

    public func execute(leagueId: Int) async throws {
        try await repository.removeFavorite(leagueId: leagueId)
    }
}
