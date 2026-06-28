//
//  LeagueLocalDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation
import SwiftData

@MainActor
public final class LeagueLocalDataSource {

    // MARK: - Properties
    private let context: ModelContext

    // MARK: - Init
    public init(context: ModelContext) {
        self.context = context
    }
}

// MARK: - Read
extension LeagueLocalDataSource {

    func getAllLeagues(sportPath: String) throws -> [LeagueCacheModel] {
        let descriptor = FetchDescriptor<LeagueCache>(
            predicate: #Predicate { $0.sport == sportPath },
            sortBy: [SortDescriptor(\.name)]
        )

        let caches = try context.fetch(descriptor)

        return caches.map {
            LeagueCacheModel(
                id: $0.id,
                name: $0.name,
                logo: $0.logo,
                sport: $0.sport,
                countryId: $0.countryId,
                countryName: $0.countryName,
                countryLogo: $0.countryLogo
            )
        }
    }

}

// MARK: - Write
extension LeagueLocalDataSource {

    func saveAllLeagues(leagues: [LeagueCache]) throws {
        leagues.forEach { context.insert($0) }
        try context.save()
    }

    func clearAllLeagues(sportPath: String) throws {
        let predicate = #Predicate<LeagueCache> { league in
            league.sport == sportPath
        }
        try context.delete(model: LeagueCache.self, where: predicate)
        try context.save()
    }
}
