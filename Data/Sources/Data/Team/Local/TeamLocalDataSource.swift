//
//  TeamLocalDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//


import SwiftData
import Foundation
import Domain

@MainActor
public final class TeamLocalDataSource {

    // MARK: - Properties
    private let context: ModelContext

    // MARK: - Init
    public init(context: ModelContext) {
        self.context = context
    }
}


extension TeamLocalDataSource {

    func getTeams(leagueId: Int) throws -> [Team] {
        try getTeamCaches(leagueId: leagueId).map { $0.toDomain() }
    }

    private func getTeamCaches(leagueId: Int) throws -> [TeamCache] {
        let predicate = #Predicate<TeamCache> {
            $0.leagueId == leagueId
        }
        let descriptor = FetchDescriptor<TeamCache>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.name)]
        )

        return try context.fetch(descriptor)
    }

}

extension TeamLocalDataSource {

    func saveTeams(teams: [TeamCache], leagueId: Int) throws {
        try clearTeams(leagueId: leagueId)
        teams.forEach { context.insert($0) }
        try context.save()
    }

    private func clearTeams(leagueId: Int) throws {
        let predicate = #Predicate<TeamCache> {
            $0.leagueId == leagueId
        }
        try context.delete(model: TeamCache.self, where: predicate)
        try context.save()
    }
}
