//
//  GetFavoritesUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 14/07/2026.
//

public final class GetFavoritesUseCase: Sendable {
    private let repository: FavoriteRepository

    public init(repository: FavoriteRepository) {
        self.repository = repository
    }

    public func execute() throws -> [League] {
        repository.getFavorites()
    }
}
