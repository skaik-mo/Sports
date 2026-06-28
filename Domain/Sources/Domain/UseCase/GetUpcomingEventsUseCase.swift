//
//  GetUpcomingEventsUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public class GetUpcomingEventsUseCase{
    private let repository: EventRepository

    public init(repository: EventRepository) {
        self.repository = repository
    }

    public func execute(sportType: SportType, leagueId: Int) async throws -> [Event] {
        try await repository.getUpcomingEvents(sportType: sportType, leagueId: leagueId)
    }
}
