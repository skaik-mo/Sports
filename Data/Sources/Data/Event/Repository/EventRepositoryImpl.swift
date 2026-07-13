//
//  EventRepositoryImpl.swift
//  Data
//
//  Created by Mohammed Skaik on 27/06/2026.
//

import Domain
import Foundation

public final class EventRepositoryImpl: EventRepository {

    // MARK: - Properties
    private let remote: EventRemoteDataSource
    private let local: EventLocalDataSource

    // MARK: - Init
    public init(
        remote: EventRemoteDataSource,
        local: EventLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }
}

public extension EventRepositoryImpl {

    func getUpcomingEvents(sportType: SportType, leagueId: Int) async throws -> [Event] {
        try await fetch(
            section: .upcoming,
            fetchRemote: {
                try await self.remote
                    .getUpcomingEvents(sportType: sportType, leagueId: leagueId)
            },
            fetchLocal: {
                try await self.local.getUpcomingEvents(leagueId: leagueId)
            },
            saveLocal: {
                try await self.local
                    .saveUpcomingEvents(events: $0, leagueId: leagueId)
            }
        )
    }

    func getLatestEvents(sportType: SportType, leagueId: Int) async throws -> [Event] {
        try await fetch(
            section: .latest,
            fetchRemote: {
                try await self.remote
                    .getLatestEvents(sportType: sportType, leagueId: leagueId)
            },
            fetchLocal: {
                try await self.local.getLatestEvents(leagueId: leagueId)
            },
            saveLocal: {
                try await self.local
                    .saveLatestEvents(events: $0, leagueId: leagueId)
            }
        )
    }
}

private extension EventRepositoryImpl {
    func fetch(
        section: EventSection,
        fetchRemote: () async throws -> [EventDto],
        fetchLocal: () async throws -> [Event],
        saveLocal: ([EventDto]) async throws -> Void
    ) async throws -> [Event] {
        do {
            let remoteEvents = try await safeCall { try await fetchRemote() }
            await cacheSilently(
                events: remoteEvents,
                saveLocal: saveLocal
            )
            return try remoteEvents.map { try $0.toDomain() }
        } catch DomainException.noInternet {
            return try await fetchFromCache(
                section: section,
                fetchLocal: fetchLocal
            )
        }
    }

    func cacheSilently(
        events: [EventDto],
        saveLocal: ([EventDto]) async throws -> Void
    ) async {
        do {
            try await saveLocal(events)
        } catch {
            debugPrint("Data: Failed to cache \(error)")
        }
    }

    func fetchFromCache(
        section: EventSection,
        fetchLocal: () async throws -> [Event]
    ) async throws -> [Event] {
        let cached = try await fetchLocal()
            .filter { isStillValid(event: $0, section: section) }

        guard !cached.isEmpty else {
            throw DomainException.noDataFound
        }
        return cached
    }

    func isStillValid(event: Event, section: EventSection) -> Bool {
        guard section == .upcoming else { return true }
        guard let date = event.date else { return false }
        return date >= Date()
    }
}
