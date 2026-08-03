//
//  ParticipantLocalDataSource.swift
//  Data
//
//  Created by Mohammed Skaik on 14/07/2026.
//


import SwiftData
import Foundation
import Domain

@MainActor
public final class ParticipantLocalDataSource {

    // MARK: - Properties
    private let context: ModelContext

    // MARK: - Init
    public init(context: ModelContext) {
        self.context = context
    }
}


extension ParticipantLocalDataSource {

    func getLeagueTeams(leagueId: Int) throws -> [Participant] {
        try getLeagueParticipants(leagueId: leagueId, type: .team).map { $0.toDomain() }
    }

    func getLeaguePlayers(leagueId: Int) throws -> [Participant] {
        try getLeagueParticipants(leagueId: leagueId, type: .player).map { $0.toDomain() }
    }

    private func getLeagueParticipants(leagueId: Int, type: ParticipantType) throws -> [ParticipantCache] {
        let typeRaw = type.rawValue
        let predicate = #Predicate<ParticipantCache> {
            $0.leagueId == leagueId && $0.type == typeRaw
        }
        let descriptor = FetchDescriptor<ParticipantCache>(predicate: predicate)
        return try context.fetch(descriptor)
    }
}

extension ParticipantLocalDataSource {

    func saveTeams(participants: [Participant], leagueId: Int) throws {
        try replaceParticipants(participants: participants, leagueId: leagueId, type: .team)
    }

    func savePlayers(participants: [Participant], leagueId: Int) throws {
        try replaceParticipants(participants: participants, leagueId: leagueId, type: .player)
    }

    private func replaceParticipants(participants: [Participant], leagueId: Int, type: ParticipantType) throws {
        try clearParticipants(leagueId: leagueId, type: type)
        let cacheModels = participants.map { $0.toCache(leagueId: leagueId, type: type) }
        cacheModels.forEach { context.insert($0) }
        try context.save()
    }
}

extension ParticipantLocalDataSource {

    private func clearParticipants(leagueId: Int, type: ParticipantType) throws {
        let typeRaw = type.rawValue
        let predicate = #Predicate<ParticipantCache> {
            $0.leagueId == leagueId && $0.type == typeRaw
        }
        try context.delete(model: ParticipantCache.self, where: predicate)
    }
}
