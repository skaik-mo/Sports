//
//  FavoriteRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 14/07/2026.
//

public protocol FavoriteRepository: Sendable {
    func toggleFavorite(leagueId: Int) async throws
    func isFavorite(leagueId: Int) async throws -> Bool
    func getFavoriteLeagueIds() async throws -> [Int]
    func removeFavorite(leagueId: Int) async throws
}
