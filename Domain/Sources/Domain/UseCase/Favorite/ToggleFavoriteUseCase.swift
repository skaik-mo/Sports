//
//  ToggleFavoriteUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 14/07/2026.
//

public final class ToggleFavoriteUseCase: Sendable {
    private let repository: FavoriteRepository

    public init(repository: FavoriteRepository) {
        self.repository = repository
    }

    public func execute(leagueId: Int) throws {
        repository.toggleFavorite(leagueId: leagueId)
    }
}
