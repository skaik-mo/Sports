//
//  EventCache.swift
//  Data
//
//  Created by Mohammed Skaik on 13/07/2026.
//

import SwiftData
import Foundation

@Model
final class EventCache {
    @Attribute(.unique)
    var id: Int
    var date: Date?
    var finalResult: String?
    var leagueId: Int
    var section: String

    var firstParticipantKey: Int
    var firstParticipantName: String?
    var firstParticipantLogo: String?

    var secondParticipantKey: Int
    var secondParticipantName: String?
    var secondParticipantLogo: String?

    init(
        id: Int,
        date: Date?,
        finalResult: String?,
        leagueId: Int,
        section: String,
        firstParticipantKey: Int,
        firstParticipantName: String?,
        firstParticipantLogo: String?,
        secondParticipantKey: Int,
        secondParticipantName: String?,
        secondParticipantLogo: String?
    ) {
        self.id = id
        self.date = date
        self.finalResult = finalResult
        self.leagueId = leagueId
        self.section = section
        self.firstParticipantKey = firstParticipantKey
        self.firstParticipantName = firstParticipantName
        self.firstParticipantLogo = firstParticipantLogo
        self.secondParticipantKey = secondParticipantKey
        self.secondParticipantName = secondParticipantName
        self.secondParticipantLogo = secondParticipantLogo
    }
}
