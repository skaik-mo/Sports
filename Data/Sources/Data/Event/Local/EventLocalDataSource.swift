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

    func getUpcomingEvents(leagueId: Int) throws -> [Event] {
        try getEvents(leagueId: leagueId, section: .upcoming).map { $0.toDomain() }
    }

    func getLatestEvents(leagueId: Int) throws -> [Event] {
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

    func saveUpcomingEvents(events: [Event], leagueId: Int, sportType: SportType) throws {
        try replaceEvents(
            events: events,
            leagueId: leagueId,
            section: .upcoming,
            sportType: sportType
        )
    }

    func saveLatestEvents(events: [Event], leagueId: Int, sportType: SportType) throws {
        try replaceEvents(
            events: events,
            leagueId: leagueId,
            section: .latest,
            sportType: sportType
        )
    }

    private func replaceEvents(events: [Event], leagueId: Int, section: EventSection, sportType: SportType) throws {
        try clearEvents(leagueId: leagueId, section: section)
        let cacheModels = events.map { $0.toCache(leagueId: leagueId, section: section) }
        cacheModels.forEach { context.insert($0) }
        try context.save()
    }

}

// MARK: - Clear
extension EventLocalDataSource {

    private func clearEvents(leagueId: Int, section: EventSection) throws {
        let sectionRaw = section.rawValue
        let predicate = #Predicate<EventCache> {
            $0.leagueId == leagueId && $0.section == sectionRaw
        }
        try context.delete(model: EventCache.self, where: predicate)
    }
}
