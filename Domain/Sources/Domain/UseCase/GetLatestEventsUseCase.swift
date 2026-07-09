//
//  GetLatestEventsUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public final class GetLatestEventsUseCase: Sendable {
    private let repository: EventRepository

    public init(repository: EventRepository) {
        self.repository = repository
    }

    public func execute(sportType: SportType, leagueId: Int) async throws -> [Event] {
        try await repository.getLatestEvents(sportType: sportType, leagueId: leagueId)
    }
}
