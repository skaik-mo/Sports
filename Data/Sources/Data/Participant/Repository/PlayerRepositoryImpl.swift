//
//  PlayerRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 03/08/2026.
//

import Domain

public final class PlayerRepositoryImpl: PlayerRepository {

    // MARK: - Properties
    private let remote: PlayerRemoteDataSource
    private let local: ParticipantLocalDataSource

    public init(
        remote: PlayerRemoteDataSource,
        local: ParticipantLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }
}

extension PlayerRepositoryImpl {

    public func getLeaguePlayers(sportType: SportType, leagueId: Int) async throws -> [Participant] {
        do {
            return try await getRemoteLeaguePlayers(
                sportType: sportType,
                leagueId: leagueId
            )
        } catch DomainException.noInternet {
            return try await getLocalLeaguePlayers(leagueId: leagueId)
        }
    }

}

private extension PlayerRepositoryImpl {
    func getRemoteLeaguePlayers(sportType: SportType, leagueId: Int) async throws -> [Participant] {
        try await safeCall {
            let dtos = try await remote.getLeaguePlayers(
                sportType: sportType,
                leagueId: leagueId
            )
            let participants = dtos.toDomain()
            await cacheSilently(participants: participants, leagueId: leagueId)
            return participants
        }
    }

    func cacheSilently(participants: [Participant], leagueId: Int) async {
        do {
            try await local
                .savePlayers(participants: participants, leagueId: leagueId)
        } catch {
            debugPrint("Data: Failed to cache teams: \(error)")
        }
    }

    func getLocalLeaguePlayers(leagueId: Int) async throws -> [Participant] {
        try await safeCall {
            let caches = try await self.local.getLeaguePlayers(leagueId: leagueId)
            guard !caches.isEmpty else {
                throw DomainException.noDataFound
            }
            return caches
        }
    }

}
