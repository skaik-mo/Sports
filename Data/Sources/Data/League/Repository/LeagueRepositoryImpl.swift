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

    public func getAllLeagues() async throws -> [League] {
        try await safeCall {
            try await local.getAllLeagues()
        }
    }
}

private extension LeagueRepositoryImpl {

    func getRemoteLeagues(sportType: SportType) async throws -> [League] {
        try await safeCall {
            let dtos = try await self.remote.getAllLeagues(sportType: sportType)
            await cacheSilently(leagues: dtos, sportType: sportType)
            return dtos.map { $0.toDomain(sportType: sportType) }
        }
    }

    func cacheSilently(leagues: [LeagueDto], sportType: SportType) async {
        do {
            let caches = leagues.map { $0.toCache(sportPath: sportType.path) }
            try await local
                .saveAllLeagues(leagues: caches, sportPath: sportType.path)
        } catch {
            debugPrint("Data: Failed to cache leagues: \(error)")
        }
    }

    func getLocalLeagues(sportType: SportType) async throws -> [League] {
        try await safeCall {
            let caches = try await self.local.getAllLeagues(
                sportPath: sportType.path
            )
            guard !caches.isEmpty else {
                throw DomainException.noDataFound
            }
            return caches
        }
    }
}
