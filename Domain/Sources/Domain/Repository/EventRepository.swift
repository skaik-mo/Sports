//
//  EventRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public protocol EventRepository {
    func getLatestEvents(sport: SportType, leagueId: Int) async throws  -> [Event]
    func getUpcomingEvents(sport: SportType, leagueId: Int) async throws  -> [Event]
}
