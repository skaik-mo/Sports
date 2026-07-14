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

    func getAllLeagues() throws -> [League] {
        try getAllLeaguesCaches().map { $0.toDomain() }
    }

    func saveAllLeagues(leagues: [LeagueCache], sportPath: String) throws {
        try clearAllLeagues(sportPath: sportPath)
        leagues.forEach { context.insert($0) }
        try context.save()
    }

}

private extension LeagueLocalDataSource {

    func getAllLeaguesCaches(sportPath: String? = nil) throws -> [LeagueCache] {
        let predicate: Predicate<LeagueCache>? = sportPath.map { sport in
            #Predicate<LeagueCache> {
                $0.sport == sport
            }
        }

        let descriptor = FetchDescriptor<LeagueCache>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.name)]
        )
        return try context.fetch(descriptor)
    }

    private func clearAllLeagues(sportPath: String) throws {
        let predicate = #Predicate<LeagueCache> { league in
            league.sport == sportPath
        }
        try context.delete(model: LeagueCache.self, where: predicate)
    }
}
