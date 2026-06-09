//
//  Event.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

import Foundation

public struct Event {
    public let id: Int
    public let sportType: SportType
    public let date: Date?
    public let finalResult: String?
    public let status: String?
    public let league: League?
    public let teams: MatchTeams?

    public static func < (lhs: Event, rhs: Event) -> Bool {
            guard let lhsDate = lhs.date, let rhsDate = rhs.date else { return false }
            return lhsDate < rhsDate
        }
}
