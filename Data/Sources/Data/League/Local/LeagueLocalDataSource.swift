//
//  LeagueLocalDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Foundation
import SwiftData
import Domain

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

    func getAllLeagues(sportPath: String) throws -> [League] {
        try self.getAllLeaguesCaches(sportPath: sportPath).map { $0.toDomain() }
    }

    private func getAllLeaguesCaches(sportPath: String) throws -> [LeagueCache] {
        let predicate = #Predicate<LeagueCache> {
            $0.sport == sportPath
        }

        let descriptor = FetchDescriptor<LeagueCache>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.name)]
        )
        return try context.fetch(descriptor)
    }

}

// MARK: - Write
extension LeagueLocalDataSource {

    func saveAllLeagues(leagues: [LeagueCache], sportPath: String) throws {
        try clearAllLeagues(sportPath: sportPath)
        leagues.forEach { context.insert($0) }
        try context.save()
    }

    private func clearAllLeagues(sportPath: String) throws {
        let predicate = #Predicate<LeagueCache> { league in
            league.sport == sportPath
        }
        try context.delete(model: LeagueCache.self, where: predicate)
        try context.save()
    }
}
