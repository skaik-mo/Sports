//
//  EventRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain

public class EventRepositoryImpl: EventRepository {

    // MARK: - Properties
    private let remote: EventRemoteDataSource

    // MARK: - Init
    public init(
        remote: EventRemoteDataSource,
    ) {
        self.remote = remote
    }
}

public extension EventRepositoryImpl {

    func getUpcomingEvents(sportType: SportType, leagueId: Int) async throws -> [Event] {
        try await safeCall {
            let dtos = try await remote.getUpcomingEvents(sportType: sportType, leagueId: leagueId)
            return try dtos.map { try $0.toDomain() }
        }
    }
    
    func getLatestEvents(sportType: SportType, leagueId: Int) async throws -> [Event] {
        try await safeCall {
            let dtos = try await remote.getLatestEvents(sportType: sportType, leagueId: leagueId)
            return try dtos.map { try $0.toDomain() }
        }
    }
}
