//
//  FavoriteRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//

import Domain

public final class FavoriteRepositoryImpl: FavoriteRepository {

    // MARK: - Properties
    private let local: FavoriteLocalDataSource

    // MARK: - Init
    public init(
        local: FavoriteLocalDataSource
    ) {
        self.local = local
    }
}

extension FavoriteRepositoryImpl {
    public func toggleFavorite(leagueId: Int) async throws {
        try await safeCall {
            try await self.local.toggleFavorite(leagueId: leagueId)
        }
    }

    public func isFavorite(leagueId: Int) async throws -> Bool {
        try await safeCall {
            try await self.local.isFavorite(leagueId: leagueId)
        }
    }

    public func getFavoriteLeagueIds() async throws -> [Int] {
        try await safeCall {
            try await self.local.getFavoriteLeagueIds()
        }
    }

    public func removeFavorite(leagueId: Int) async throws {
        try await safeCall {
            try await self.local.clearFavorite(leagueId: leagueId)
        }
    }
}
