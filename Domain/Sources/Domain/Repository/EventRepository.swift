//
//  EventRepository.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

public protocol EventRepository {
    func getLatestEvents(sportType: SportType, leagueId: Int) async throws  -> [Event]
    func getUpcomingEvents(sportType: SportType, leagueId: Int) async throws  -> [Event]
}
