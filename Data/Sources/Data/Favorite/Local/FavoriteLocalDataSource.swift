//
//  FavoriteLocalDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//

import SwiftData
import Foundation

@MainActor
public final class FavoriteLocalDataSource {

    // MARK: - Properties
    private let context: ModelContext

    // MARK: - Init
    public init(context: ModelContext) {
        self.context = context
    }
}

extension FavoriteLocalDataSource {

    func toggleFavorite(leagueId: Int) throws {
        if try isFavorite(leagueId: leagueId) {
            try clearFavorite(leagueId: leagueId)
        } else {
            try addFavorite(leagueId: leagueId)
        }
    }

    private func addFavorite(leagueId: Int) throws {
        let league = FavoriteCache(id: leagueId)
        context.insert(league)
        try context.save()
    }

    func isFavorite(leagueId: Int) throws -> Bool {
        let predicate = #Predicate<FavoriteCache> {
            $0.id == leagueId
        }
        var descriptor = FetchDescriptor<FavoriteCache>(
            predicate: predicate
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).isEmpty == false
    }

    func getFavoriteLeagueIds() throws -> [Int] {
        let descriptor = FetchDescriptor<FavoriteCache>()
        return try context.fetch(descriptor).map { $0.id }
    }

    func clearFavorite(leagueId: Int) throws {
        let predicate = #Predicate<FavoriteCache> {
            $0.id == leagueId
        }
        try context.delete(model: FavoriteCache.self, where: predicate)
    }
}
