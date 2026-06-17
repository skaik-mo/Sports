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

    public func getAllLeagues(sport: SportType) async throws -> [League] {
        let sportDto = SportTypeDto.sportMapper(from: sport)
        do {
            return try await getRemoteLeagues(sportDto: sportDto)

        } catch let error as NetworkError where error == .noInternetConnection {
            let snapshots = try await getLocalLeagues(
                sportDto: sportDto,
                fallback: error
            )
            return snapshots.map { $0.toDomain() }
        }
    }
}

private extension LeagueRepositoryImpl {

    func getRemoteLeagues(sportDto: SportTypeDto) async throws -> [League] {
        let dtos = try await remote.getAllLeagues(sportDto: sportDto)
        let caches = dtos.map { $0.toCache(sportDto: sportDto) }
        try await local.clearAllLeagues(sportDto: sportDto)
        try await local.saveAllLeagues(leagues: caches)
        return dtos.map { $0.toDomain() }
    }

    func getLocalLeagues(sportDto: SportTypeDto, fallback: NetworkError) async throws -> [LeagueCacheModel] {
        let snapshots = try await local.getAllLeagues(sportDto: sportDto)
        guard !snapshots.isEmpty else {
            throw fallback
        }
        return snapshots
    }
}
