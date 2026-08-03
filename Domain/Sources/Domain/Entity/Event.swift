//
//  Event.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

import Foundation

public struct Event: Sendable {
    public let id: Int
    public let date: Date?
    public let finalResult: String?
    public let firstParticipant: Participant
    public let secondParticipant: Participant

    public init(
        id: Int,
        date: Date?,
        finalResult: String?,
        firstParticipant: Participant,
        secondParticipant: Participant
    ) {
        self.id = id
        self.date = date
        self.finalResult = finalResult
        self.firstParticipant = firstParticipant
        self.secondParticipant = secondParticipant
    }

    public static func < (lhs: Event, rhs: Event) -> Bool {
        guard let lhsDate = lhs.date, let rhsDate = rhs.date else {
            return false
        }
        return lhsDate < rhsDate
    }

    public static func > (lhs: Event, rhs: Event) -> Bool {
        guard let lhsDate = lhs.date, let rhsDate = rhs.date else {
            return false
        }
        return lhsDate > rhsDate
    }
}
