//
//  EventLocalDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 13/07/2026.
//


import SwiftData
import Foundation
import Domain

@MainActor
public final class EventLocalDataSource {

    // MARK: - Properties
    private let context: ModelContext

    // MARK: - Init
    public init(context: ModelContext) {
        self.context = context
    }
}

// MARK: - Get
extension EventLocalDataSource {

    func getUpcomingEvents(leagueId: Int) async throws -> [Event] {
        try getEvents(leagueId: leagueId, section: .upcoming).map { $0.toDomain() }
    }

    func getLatestEvents(leagueId: Int) async throws -> [Event] {
        try getEvents(leagueId: leagueId, section: .latest).map { $0.toDomain() }
    }

    private func getEvents(leagueId: Int, section: EventSection) throws -> [EventCache] {
        let sectionRaw = section.rawValue
        let predicate = #Predicate<EventCache> {
            $0.leagueId == leagueId && $0.section == sectionRaw
        }
        let descriptor = FetchDescriptor<EventCache>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .forward)]
        )
        return try context.fetch(descriptor)
    }


}

// MARK: - Save
extension EventLocalDataSource {

    func saveUpcomingEvents(events: [EventDto], leagueId: Int) async throws {
        try replaceEvents(
            events: events,
            leagueId: leagueId,
            section: .upcoming
        )
    }

    func saveLatestEvents(events: [EventDto], leagueId: Int) async throws {
        try replaceEvents(
            events: events,
            leagueId: leagueId,
            section: .latest
        )
    }

    private func replaceEvents(events: [EventDto], leagueId: Int, section: EventSection) throws {
        try clearEvents(leagueId: leagueId, section: section)
        let cacheModels = try events.map { try $0.toCache(leagueId: leagueId, section: section) }
        cacheModels.forEach { context.insert($0) }
        try context.save()
    }

}

// MARK: - Clear
extension EventLocalDataSource {

    func clearUpcomingEvents(leagueId: Int) async throws {
        try clearEvents(leagueId: leagueId, section: .upcoming)
    }

    func clearLatestEvents(leagueId: Int) async throws {
        try clearEvents(leagueId: leagueId, section: .latest)
    }

    private func clearEvents(leagueId: Int, section: EventSection) throws {
        let sectionRaw = section.rawValue
        let predicate = #Predicate<EventCache> {
            $0.leagueId == leagueId && $0.section == sectionRaw
        }
        let existing = try context.fetch(
            FetchDescriptor<EventCache>(predicate: predicate)
        )
        existing.forEach { context.delete($0) }
    }

}
