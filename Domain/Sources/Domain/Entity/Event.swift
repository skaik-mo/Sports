//
//  Event.swift
//  Domain
//
//  Created by Mohammed Skaik on 09/06/2026.
//

import Foundation

public struct Event {
    public let id: Int
    public let date: Date?
    public let finalResult: String?
    public let status: String?
    public let teams: MatchTeams?

    public init(id: Int, date: Date?, finalResult: String?, status: String?, teams: MatchTeams?) {
        self.id = id
        self.date = date
        self.finalResult = finalResult
        self.status = status
        self.teams = teams
    }

    public static func < (lhs: Event, rhs: Event) -> Bool {
            guard let lhsDate = lhs.date, let rhsDate = rhs.date else { return false }
            return lhsDate < rhsDate
        }
}
