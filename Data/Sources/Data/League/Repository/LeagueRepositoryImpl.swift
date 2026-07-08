//
//  LeagueRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 14/06/2026.
//

import Domain
import Networking

public final class LeagueRepositoryImpl: LeagueRepository {

    // MARK: - Properties
    private let remote: LeagueRemoteDataSource
    private let local: LeagueLocalDataSource

    // MARK: - Init
    public init(
        remote: LeagueRemoteDataSource,
        local: LeagueLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }
}

// MARK: - Leagues
extension LeagueRepositoryImpl {

    public func getAllLeagues(sportType: SportType) async throws -> [League] {
        do {
            return try await getRemoteLeagues(sportType: sportType)
        } catch DomainException.noInternet {
            return try await getLocalLeagues(sportType: sportType)
        }
    }
}

private extension LeagueRepositoryImpl {

    func getRemoteLeagues(sportType: SportType) async throws -> [League] {
        try await safeCall {
            let dtos = try await self.remote.getAllLeagues(sportType: sportType)
            let sportPath = sportType.path
            let caches = dtos.map { $0.toCache(sportPath: sportPath) }
            try await self.local.clearAllLeagues(sportPath: sportPath)
            try await self.local.saveAllLeagues(leagues: caches)
            return dtos.map { $0.toDomain() }
        }
    }

    func getLocalLeagues(sportType: SportType) async throws -> [League] {
        try await safeCall {
            let snapshots = try await self.local.getAllLeagues(
                sportPath: sportType.path
            )
            guard !snapshots.isEmpty else {
                throw DomainException.noDataFound
            }
            return snapshots.map { $0.toDomain() }
        }
    }
}
