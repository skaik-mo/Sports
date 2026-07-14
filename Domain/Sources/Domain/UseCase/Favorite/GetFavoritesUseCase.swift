//
//  GetFavoritesUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 14/07/2026.
//

public final class GetFavoritesUseCase: Sendable {
    private let favoriteRepository: FavoriteRepository
    private let leagueRepository: LeagueRepository

    public init(favoriteRepository: FavoriteRepository, leagueRepository: LeagueRepository) {
        self.favoriteRepository = favoriteRepository
        self.leagueRepository = leagueRepository
    }

    public func execute() async throws -> [League] {
        let favoriteIds = try await favoriteRepository.getFavoriteLeagueIds()
        guard !favoriteIds.isEmpty else { return [] }

        let allLeagues = try await leagueRepository.getAllLeagues()
        return allLeagues.filter { favoriteIds.contains($0.id) }
    }
}
