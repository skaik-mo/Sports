//
//  TeamRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 03/08/2026.
//

import Domain

public final class TeamRepositoryImpl: TeamRepository {

    // MARK: - Properties
    private let remote: TeamRemoteDataSource
    private let local: ParticipantLocalDataSource

    // MARK: - Init
    public init(
        remote: TeamRemoteDataSource,
        local: ParticipantLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }
}

extension TeamRepositoryImpl {


    public func getLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Participant] {
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
    func getRemoteLeagueTeams(sportType: SportType, leagueId: Int) async throws -> [Participant] {
        try await safeCall {
            let dtos = try await remote.getLeagueTeams(
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
                .saveTeams(participants: participants, leagueId: leagueId)
        } catch {
            debugPrint("Data: Failed to cache teams: \(error)")
        }
    }

    func getLocalLeagueTeams(leagueId: Int) async throws -> [Participant] {
        try await safeCall {
            let caches = try await self.local.getLeagueTeams(leagueId: leagueId)
            guard !caches.isEmpty else {
                throw DomainException.noDataFound
            }
            return caches
        }
    }
}
