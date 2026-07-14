//
//  TeamRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain

public final class TeamRepositoryImpl: TeamRepository {

    // MARK: - Properties
    private let remote: TeamRemoteDataSource
    private let local: TeamLocalDataSource

    // MARK: - Init
    public init(
        remote: TeamRemoteDataSource,
        local: TeamLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }

}

extension TeamRepositoryImpl {

    public func getLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Team] {
        do {
            return try await getRemoteLeagueTeams(
                sportType: sportType,
                leagueId: leagueId
            )
        } catch DomainException.noInternet {
            return try await getLocalLeagueTeams(leagueId: leagueId)
        }
    }
}

private extension TeamRepositoryImpl {
    func getRemoteLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Team] {
        try await safeCall {
            let dtos = try await remote.getLeagueTeams(
                sportType: sportType,
                leagueId: leagueId
            )
            await cacheSilently(teams: dtos, leagueId: leagueId)
            return dtos.map { $0.toDomain() }
        }
    }

    func cacheSilently(teams: [TeamDto], leagueId: Int) async {
        do {
            let caches = teams.map { $0.toCache(leagueId: leagueId) }
            try await local.saveTeams(teams: caches, leagueId: leagueId)
        } catch {
            debugPrint("Data: Failed to cache teams: \(error)")
        }
    }

    func getLocalLeagueTeams(leagueId: Int) async throws -> [Team] {
        try await safeCall {
            let caches = try await self.local.getTeams(leagueId: leagueId)
            guard !caches.isEmpty else {
                throw DomainException.noDataFound
            }
            return caches
        }
    }
}
