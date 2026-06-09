//
//  GetLatestEventsUseCase.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

class GetLatestEventsUseCase {
    private let repository: EventRepository

    init(repository: EventRepository) {
        self.repository = repository
    }

    func execute(sport: SportType, leagueId: Int) async throws -> [Event] {
        try await repository.getLatestEvents(sport: sport, leagueId: leagueId)
    }
}
