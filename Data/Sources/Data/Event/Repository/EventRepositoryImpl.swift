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

    func getUpcomingEvents(sport: SportType, leagueId: Int) async throws -> [Event] {
        let sportDto = SportTypeDto.sportMapper(from: sport)
        let dtos = try await remote.getUpcomingEvents(sportDto: sportDto, leagueId: leagueId)
        return try dtos.map { try $0.toDomain() }
    }
    
    func getLatestEvents(sport: SportType, leagueId: Int) async throws -> [Event] {
        let sportDto = SportTypeDto.sportMapper(from: sport)
        let dtos = try await remote.getLatestEvents(sportDto: sportDto, leagueId: leagueId)
        return try dtos.map { try $0.toDomain() }
    }

    func GetTeams(sport: SportType, leagueId: Int) async throws -> [Team] {
        []
    }
}
