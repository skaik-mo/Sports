//
//  FavoriteRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 14/07/2026.
//

public protocol FavoriteRepository: Sendable {
    func toggleFavorite(leagueId: Int)
    func isFavorite(leagueId: Int) -> Bool
    func getFavorites() -> [League]
    func removeFavorite(leagueId: Int)
}
